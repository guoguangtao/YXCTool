//
//  UIColor+YXC_Category.h
//  YXCTools
//
//  Created by lbkj on 2021/10/25.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (YXC_Category)

/// 设置亮色与暗黑模式下的颜色
/// @param lightColor 亮色
/// @param darkColor 暗黑模式下的颜色
+ (UIColor *)yxc_colorWithLightColor:(UIColor *)lightColor darkColor:(UIColor *)darkColor;

@end

NS_ASSUME_NONNULL_END
