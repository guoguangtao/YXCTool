//
//  UIColor+YXC_Category.m
//  YXCTools
//
//  Created by lbkj on 2021/10/25.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "UIColor+YXC_Category.h"

@implementation UIColor (YXC_Category)

/// 设置亮色与暗黑模式下的颜色
/// @param lightColor 亮色
/// @param darkColor 暗黑模式下的颜色
+ (UIColor *)yxc_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor {
    
    if (@available(iOS 13.0, *)) {
        return [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull traitCollection) {
            if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleDark) {
                return darkColor;
            } else {
                return lightColor;
            }
        }];
    } else {
        return lightColor;
    }
}

@end
