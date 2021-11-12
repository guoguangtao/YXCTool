//
//  YXCControllerModel.m
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCControllerModel.h"

@interface YXCControllerModel ()



@end

@implementation YXCControllerModel

#pragma mark - Lifecycle




#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

+ (instancetype)modelWithClassName:(NSString *)className title:(NSString *)title parameter:(NSDictionary *)parameter {
    
    YXCControllerModel *model = [YXCControllerModel new];
    model.className = className;
    model.title = title;
    model.parameter = parameter;
    
    return model;
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
