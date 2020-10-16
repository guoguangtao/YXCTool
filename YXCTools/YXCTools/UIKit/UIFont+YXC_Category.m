//
//  UIFont+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/7/13.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIFont+YXC_Category.h"
#import <objc/runtime.h>

#define DESIGN_SCREEN_WIDTH  750

@implementation UIFont (YXC_Category)

+ (void)load {
    
    Method system_systemFontOfSize_method = class_getClassMethod([self class],
                                                                 @selector(systemFontOfSize:));
    Method my_systemFontOfSize_method = class_getInstanceMethod([self class],
                                                                @selector(yxc_systemFontOfSize:));
    method_exchangeImplementations(system_systemFontOfSize_method,
                                   my_systemFontOfSize_method);
    
    Method system_systemFontOfSizeWeight_method = class_getClassMethod([self class],
                                                                       @selector(systemFontOfSize:weight:));
    Method my_systemFontOfSizeWeight_method = class_getClassMethod([self class],
                                                                   @selector(yxc_systemFontOfSize:weight:));
    method_exchangeImplementations(system_systemFontOfSizeWeight_method,
                                   my_systemFontOfSizeWeight_method);
}

+ (UIFont *)yxc_systemFontOfSize:(CGFloat)fontSize {
    
    return [UIFont yxc_systemFontOfSize:[self yxc_fontSizeWithSize:fontSize]];
}

+ (CGFloat)yxc_fontSizeWithSize:(CGFloat)fontSize {
    
    return [UIScreen mainScreen].bounds.size.width / DESIGN_SCREEN_WIDTH * 2 * fontSize;
}

+ (UIFont *)yxc_systemFontOfSize:(CGFloat)fontSize weight:(UIFontWeight)weight {
    
    return [UIFont yxc_systemFontOfSize:[self yxc_fontSizeWithSize:fontSize]
                                 weight:weight];
}

@end
