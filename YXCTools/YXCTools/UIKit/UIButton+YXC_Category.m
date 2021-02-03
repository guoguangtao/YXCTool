//
//  UIButton+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIButton+YXC_Category.h"
#import "UIImage+YXC_Category.h"

@implementation UIButton (YXC_Category)

+ (void)load {
    
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(layoutSubviews)
                          currentSelector:@selector(yxc_layoutSubviews)];
}

- (void)yxc_layoutSubviews {
    [self yxc_layoutSubviews];
    
}

/// 设置背景颜色
/// @param color 颜色
/// @param state 状态
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:state];
}

///  设置图片
/// @param imageName 图片名称
/// @param state 状态
- (void)yxc_setImage:(NSString *)imageName forState:(UIControlState)state {
    
    if (![imageName checkString]) return;
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

@end
