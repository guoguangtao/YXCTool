//
//  YXCScanTools.m
//  YXCTools
//
//  Created by guogt on 2022/5/13.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCScanTools.h"

@implementation YXCScanTools


#pragma mark - Lifecycle

- (void)dealloc {

}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

+ (AVAuthorizationStatus)getAuthorizationStatus{
    return  [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
}

///  请求授权
+ (void)requestAuthorization:(AVAuthorizationSuccess)success{
    AVAuthorizationStatus status = [self getAuthorizationStatus];
    // 还未授权
    if (status == AVAuthorizationStatusNotDetermined) {
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            success(granted);
        }];
        
    }else if (status == AVAuthorizationStatusRestricted){
        // 拒绝
        success(NO);
    }else if (status == AVAuthorizationStatusDenied){
        // 限制
        success(NO);
    }else if (status == AVAuthorizationStatusAuthorized){
        // 已授权
        success(YES);
    }
}

#pragma mark - 跳转到系统本app访问设置
+ (void)jumpSystemSelfAppAccessSettings{
    // 获取包名
    // 跳转到程序访问设置
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]
                                       options:@{}
                             completionHandler:^(BOOL success) {
    }];
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
