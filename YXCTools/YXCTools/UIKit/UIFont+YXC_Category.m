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
    
    [self hookClassMethodWithTargetCls:[self class] currentCls:[self class] targetSelector:@selector(systemFontOfSize:) currentSelector:@selector(yxc_systemFontOfSize:)];
    
    [self hookClassMethodWithTargetCls:[self class] currentCls:[self class] targetSelector:@selector(systemFontOfSize:weight:) currentSelector:@selector(yxc_systemFontOfSize:weight:)];
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
