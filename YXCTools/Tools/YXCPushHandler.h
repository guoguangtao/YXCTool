//
//  YXCPushHandler.h
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YXCControllerModel;

/// 控制器跳转路由
@interface YXCPushHandler : NSObject

#pragma mark - Property


#pragma mark - Method


/// 以 push 的方式跳转控制器
/// @param controller 控制器
/// @param model 需要跳转控制器的模型数据
+ (void)pushController:(UIViewController *)controller model:(YXCControllerModel *)model;

/// 以 Present 的方式跳转控制器
/// @param model 需要跳转控制器的模型数据
+ (void)presentController:(UIViewController *)controller model:(YXCControllerModel *)model;

@end
