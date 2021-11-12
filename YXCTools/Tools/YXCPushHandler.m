//
//  YXCPushHandler.m
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPushHandler.h"
#import "YXCBaseController.h"

@interface YXCPushHandler ()



@end

@implementation YXCPushHandler

#pragma mark - Lifecycle




#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Getter


#pragma mark - Public


/// 以 push 的方式跳转控制器
/// @param controller 上一层控制器
/// @param model 需要跳转控制器的模型数据
+ (void)pushController:(UIViewController *)controller model:(YXCControllerModel *)model {
    
    if (controller.navigationController) {
        if (model.className.length) {
            YXCBaseController *vc = [NSClassFromString(model.className) new];
            if ([vc isKindOfClass:[YXCBaseController class]]) {
                vc.title = model.title;
                vc.parameter = model.parameter;
                [controller.navigationController pushViewController:vc animated:YES];
            }
        }
    }
}

/// 以 Present 的方式跳转控制器
/// @param controller 上一层控制器
/// @param model 需要跳转控制器的模型数据
+ (void)presentController:(UIViewController *)controller model:(YXCControllerModel *)model {
    
    if (model.className.length) {
        YXCBaseController *vc = [NSClassFromString(model.className) new];
        if ([vc isKindOfClass:[YXCBaseController class]]) {
            vc.title = model.title;
            vc.parameter = model.parameter;
            [controller presentViewController:controller animated:YES completion:nil];
        }
    }
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
