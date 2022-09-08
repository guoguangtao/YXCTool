//
//  YXCScanQRCodeController.m
//  YXCTools
//
//  Created by guogt on 2022/5/13.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCScanQRCodeController.h"
#import "YXCScanView.h"
#import "YXCScanTools.h"
#import "NSObject+YXC_Category.h"

@interface YXCScanQRCodeController ()<AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, strong) YXCScanView *scanView; /**< 扫描二维码界面 */
@property (nonatomic, strong) AVCaptureDevice *captureDevice;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) AVCaptureMetadataOutput *metaDataOutput;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videDataOutPut;
@property (nonatomic, strong) AVCaptureSession *captureSession;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation YXCScanQRCodeController

/// 刷新UI
- (void)injected {

}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self p_authenicaScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    self.navigationController.navigationBarHidden = NO;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];

    [self p_stopScan];
}

- (void)dealloc {

    YXCDebugLogMethod();
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)back {

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Public


#pragma mark - Private


/// 获取摄像头使用权
- (void)p_authenicaScan {

    AVAuthorizationStatus status = [YXCScanTools getAuthorizationStatus];
    if (status == AVAuthorizationStatusNotDetermined) {
        //请求授权
        
        [YXCScanTools requestAuthorization:^(BOOL success) {
            if (success) {
                [self p_startScan];
            }
        }];
    }else if (status == AVAuthorizationStatusAuthorized){
        // 已经授权
        [self p_startScan];
    } else if (status == AVAuthorizationStatusRestricted || status == AVAuthorizationStatusDenied){
        // 权限限制
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"扫一扫"
                                                                       message:@"相机权限未打开,扫码不能用,前往设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                                  style:UIAlertActionStyleDefault
                                                handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定"
                                                  style:UIAlertActionStyleDefault
                                                handler:^(UIAlertAction * _Nonnull action) {
            [YXCScanTools jumpSystemSelfAppAccessSettings];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

/// 开始扫描
- (void)p_startScan {

    [self p_configCaptureDevice];
}

/// 停止扫描
- (void)p_stopScan {

    [self.scanView stopAnimation];
    if (self.captureSession) {
        [self.captureSession stopRunning];
        self.captureSession = nil;
    }

    self.captureDevice = nil;
    self.deviceInput = nil;
    self.metaDataOutput = nil;
    self.videDataOutPut = nil;
    self.captureSession = nil;
//    [self.previewLayer removeFromSuperlayer];
//    self.previewLayer = nil;
}


/// 配置扫描
- (void)p_configCaptureDevice {

    if (self.captureDevice != nil) return;

    self.captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    NSError *error = nil;
    [self.captureDevice lockForConfiguration:&error];
    if (error == nil) {
        if (self.captureDevice.isSmoothAutoFocusSupported && self.captureDevice.isSmoothAutoFocusEnabled == NO) {
            self.captureDevice.smoothAutoFocusEnabled = YES;
            NSLog(@"确定启用平滑自动对焦");
        }
        if (self.captureDevice.isAutoFocusRangeRestrictionSupported) {
            self.captureDevice.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionFar;
        }
        if ([self.captureDevice isFocusModeSupported:AVCaptureFocusModeAutoFocus] &&
            self.captureDevice.focusMode != AVCaptureFocusModeContinuousAutoFocus) {
            self.captureDevice.focusMode = AVCaptureFocusModeContinuousAutoFocus;
            NSLog(@"确定设备对焦模式--%ld", (long)self.captureDevice.focusMode);
        }
        NSLog(@"autoFocusRangeRestrictionSupported:%d,---autoFocusRangeRestriction:%ld", self.captureDevice.autoFocusRangeRestrictionSupported, (long)self.captureDevice.autoFocusRangeRestriction);
        if ([self.captureDevice isExposureModeSupported:AVCaptureExposureModeContinuousAutoExposure]) {
            self.captureDevice.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        }
        [self.captureDevice unlockForConfiguration];
    }

    self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:self.captureDevice error:nil];

    self.metaDataOutput = [AVCaptureMetadataOutput new];
    [self.metaDataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];

    self.videDataOutPut = [AVCaptureVideoDataOutput new];
    self.videDataOutPut.videoSettings = [NSDictionary dictionaryWithObjectsAndKeys:@(kCVPixelFormatType_32BGRA), kCVPixelBufferPixelFormatTypeKey, nil];
//    dispatch_queue_t queue = dispatch_queue_create("com.hpplay.queue.video.output", DISPATCH_QUEUE_SERIAL);
//    [self.videDataOutPut setSampleBufferDelegate:self queue:queue];
    self.videDataOutPut.alwaysDiscardsLateVideoFrames = YES;

    self.captureSession = [AVCaptureSession new];
    self.captureSession.sessionPreset = AVCaptureSessionPresetHigh;
    if ([self.captureSession canAddInput:self.deviceInput]) {
        [self.captureSession addInput:self.deviceInput];
    }
    if ([self.captureSession canAddOutput:self.metaDataOutput]) {
        [self.captureSession addOutput:self.metaDataOutput];
    }
    if ([self.captureSession canAddOutput:self.videDataOutPut]) {
        [self.captureSession addOutput:self.videDataOutPut];
    }

    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.captureSession];
    self.previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    dispatch_async(dispatch_get_main_queue(), ^{
        self.view.backgroundColor = UIColor.clearColor;
        self.previewLayer.frame = self.view.layer.bounds;
        [self.view.layer insertSublayer:self.previewLayer atIndex:0];
        [self.captureSession startRunning];
        [self.scanView startAnimation];
        #if TARGET_IPHONE_SIMULATOR//模拟器

        #else
        self.metaDataOutput.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
        #endif
    });
}

/// 自动聚焦
- (void)p_changeVideoScale:(AVMetadataMachineReadableCodeObject *)objc {

    NSArray *array = objc.corners;
    NSLog(@"cornersArray:%@", array);

    CGPoint point_01 = CGPointZero;
    CFDictionaryRef ref_01 = (__bridge CFDictionaryRef)[array firstObject];
    CGPointMakeWithDictionaryRepresentation(ref_01, &point_01);
    NSLog(@"point_01.x : %lf, point_01.y : %lf", point_01.x, point_01.y);

    CGPoint point_02 = CGPointZero;
    CFDictionaryRef ref_02 = (__bridge CFDictionaryRef)array[2];
    CGPointMakeWithDictionaryRepresentation(ref_02, &point_02);
    NSLog(@"point_02.x : %lf, point_02.y : %lf", point_02.x, point_02.y);

    CGFloat scale = 90 / (NSInteger)((point_02.x - point_01.x) * self.view.bounds.size.width);
    [self p_setVideoScale:scale];
}

/// 设置聚焦
- (void)p_setVideoScale:(CGFloat)scale {

    NSLog(@"----scale:%lf", scale);
    [self.captureDevice lockForConfiguration:nil];
    CGFloat videoMaxZoomFactor = self.captureDevice.activeFormat.videoMaxZoomFactor;
    if (scale < 1) {
        scale = 1;
    } else if (scale > videoMaxZoomFactor) {
        scale = videoMaxZoomFactor;
    }
    NSLog(@"====scale:%lf", scale);
    [self.captureDevice rampToVideoZoomFactor:scale withRate:5];
    [self.deviceInput.device unlockForConfiguration];
}

- (AVCaptureConnection *)p_connectionWithMediaType:(NSString *)mediaType fromConnections:(NSArray *)connections {

    for (AVCaptureConnection *connection in connections) {
        for (AVCaptureInputPort *port in [connection inputPorts]) {
            if ([[port mediaType] isEqualToString:mediaType]) {
                return connection;
            }
        }
    }

    return nil;
}


#pragma mark - Protocol

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects
       fromConnection:(AVCaptureConnection *)connection {

    NSString *stringValue = nil;
    if (metadataObjects != nil && metadataObjects.count) {
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        stringValue = metadataObject.stringValue;
        if (stringValue.checkString) {
            NSLog(@"识别二维码:%@", stringValue);
        }
        [self p_changeVideoScale:metadataObject];
    }
}


#pragma mark - UI

- (void)setupUI {

    self.view.backgroundColor = UIColor.blackColor;
    [self.view addSubview:self.scanView];
}


#pragma mark - Constraints

- (void)setupConstraints {

    [self.scanView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - Lazy

- (YXCScanView *)scanView {
    if (_scanView) return _scanView;

    _scanView = [YXCScanView new];
    [_scanView addBackAction:@selector(back) target:self];
    return _scanView;
}


@end
