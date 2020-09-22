//
//  YXCPhotoHandler.m
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoHandler.h"

@interface YXCPhotoHandler ()



@end

@implementation YXCPhotoHandler

#pragma mark - Lifecycle

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

/// 相机权限
+ (BOOL)cameraAuthorizationStatusCompletionHandler:(void (^)(BOOL))handler {
    
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
                if (handler) {
                    handler(granted);
                }
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
+ (BOOL)photoAuthorizationStatus:(void (^)(PHAuthorizationStatus))handler {
    
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
                if (handler) {
                    handler(status);
                }
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
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
