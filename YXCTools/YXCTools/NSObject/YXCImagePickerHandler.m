//
//  YXCImagePickerHandler.m
//  YXCTools
//
//  Created by GGT on 2020/8/28.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCImagePickerHandler.h"
#import <Photos/Photos.h>
#import <AVFoundation/AVFoundation.h>

@interface YXCImagePickerHandler ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) UIViewController *owner; /**< 拥有者 */
@property (nonatomic, copy) YXCImagePickerComplete complete; /**< 回调 */
@property (nonatomic, assign) BOOL allowsEditing;/**< 是否允许被编辑 */

@end

@implementation YXCImagePickerHandler

#pragma mark - Lifecycle

static YXCImagePickerHandler *_instance;

+ (instancetype)shareImagePicker {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    
    return _instance;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

/// 选择相片或者拍照
/// @param owner 拥有者(利用 owner 跳转到 UIImagePickerController)
/// @param allowsEditing 是否允许编辑
/// @param complete 编辑或者选择照片/完成拍照回调
- (void)choosePhotoOrCameraWithController:(UIViewController *)owner
                            allowsEditing:(BOOL)allowsEditing
                                 complete:(YXCImagePickerComplete)complete {
    
    if (owner == nil) return;
    
    self.owner = owner;
    self.complete = complete;
    self.allowsEditing = allowsEditing;
    [self chooseCameraOrPhotoLibrary];
}


#pragma mark - Private

/// 选择访问相册还是拍照
- (void)chooseCameraOrPhotoLibrary {
    
    // 弹出 拍照 、相册、取消选项
    UIAlertController *alerVC = [UIAlertController alertControllerWithTitle:@"选择图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoImagePickerController:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *photoAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self gotoImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alerVC addAction:cameraAction];
    [alerVC addAction:photoAction];
    [alerVC addAction:cancelAction];
    [self.owner presentViewController:alerVC animated:YES completion:nil];
}

/// 跳转相机或者相册
/// @param sourceType 相机/相册选项
- (void)gotoImagePickerController:(UIImagePickerControllerSourceType)sourceType {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (sourceType == UIImagePickerControllerSourceTypeCamera) {
            // 判断当前设备相机是否可用
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                [self showAlertWithTitle:@"当前设备相机不可用" message:@""];
                return;
            }
            // 相机访问权限
            if ([self cameraAuthorizationStatus] == NO) return;
        } else if (sourceType == UIImagePickerControllerSourceTypePhotoLibrary) {
            // 相册访问权限
            if (![self photoAuthorizationStatus]) return;
        }
        
        UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.sourceType = sourceType;
        imagePicker.allowsEditing = self.allowsEditing;
        // iOS13 无法全屏，加上这句代码全屏设置，iOS13 默认 UIModalPresentationAutomatic
        imagePicker.modalPresentationStyle = UIModalPresentationFullScreen;
        imagePicker.delegate = self;
        [self.owner presentViewController:imagePicker animated:YES completion:nil];
    });
}

/// 相机权限
- (BOOL)cameraAuthorizationStatus {
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined: YXCLog(@"还没申请权限,现在开始申请"); break;
        case AVAuthorizationStatusRestricted : YXCLog(@"相机受限制"); break;
        case AVAuthorizationStatusDenied : YXCLog(@"相机权限被拒绝"); break;
        case AVAuthorizationStatusAuthorized : YXCLog(@"相机权限已授权"); break;
    }
    
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        // 还未申请权限,申请权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                [self gotoImagePickerController:UIImagePickerControllerSourceTypeCamera];
            }];
        });
    } else if (authStatus != AVAuthorizationStatusAuthorized) {
        // 相机权限未授予
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (appName == nil) {
            appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        };
        NSString *title = [NSString stringWithFormat:@"请在“设置-隐私-相机”选项中允许<< %@ >>访问你的相机", appName];
        [self showAlertWithTitle:title message:nil];
    }

    return authStatus == AVAuthorizationStatusAuthorized;
}

/// 相册权限
- (BOOL)photoAuthorizationStatus {
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authStatus) {
        case PHAuthorizationStatusNotDetermined: YXCLog(@"相册还没申请权限,现在开始申请"); break;
        case PHAuthorizationStatusRestricted : YXCLog(@"相册受限制"); break;
        case PHAuthorizationStatusDenied : YXCLog(@"相册权限被拒绝"); break;
        case PHAuthorizationStatusAuthorized : YXCLog(@"相册权限已授权"); break;
        case PHAuthorizationStatusLimited: YXCLog(@"相册部分授权"); break;
    }
    
    if (authStatus == PHAuthorizationStatusNotDetermined) {
        // 还未申请权限,申请权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                [self gotoImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
            }];
        });
    } else if (authStatus != PHAuthorizationStatusAuthorized) {
        // 相机权限未授予
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (appName == nil) {
            appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        };
        NSString *title = [NSString stringWithFormat:@"请在“设置-隐私-相册”选项中允许<< %@ >>访问你的相册", appName];
        [self showAlertWithTitle:title message:nil];
    }

    return authStatus == PHAuthorizationStatusAuthorized;
}

/// 弹窗提示
/// @param title 提示标题
/// @param message 提示信息
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.owner presentViewController:alertController animated:YES completion:nil];
    });
}


#pragma mark - Protocol

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 不允许裁剪获取 UIImagePickerControllerOriginalImage
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    if (self.allowsEditing) {
        // 允许裁剪获取 UIImagePickerControllerEditedImage
        image = info[UIImagePickerControllerEditedImage];
    }
    
    if (self.complete) {
        self.complete(image, info);
    }
}


#pragma mark - 懒加载



@end
