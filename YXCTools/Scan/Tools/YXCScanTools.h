//
//  YXCScanTools.h
//  YXCTools
//
//  Created by guogt on 2022/5/13.
//  Copyright © 2022 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef void(^AVAuthorizationSuccess)(BOOL success);

NS_ASSUME_NONNULL_BEGIN

@interface YXCScanTools : NSObject

#pragma mark - Property


#pragma mark - Method

///  获取相机授权状态
+ (AVAuthorizationStatus)getAuthorizationStatus;

///  请求授权
+ (void)requestAuthorization:(AVAuthorizationSuccess)success;

///  跳转到系统本app访问设置
+ (void)jumpSystemSelfAppAccessSettings;

@end

NS_ASSUME_NONNULL_END
