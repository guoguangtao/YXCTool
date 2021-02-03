//
//  UIButton+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YXCButtonImagePosition) {
    YXCButtonImagePositionLeft = 0,
    YXCButtonImagePositionTop,
    YXCButtonImagePositionRight,
    YXCButtonImagePositionBottom,
};

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (YXC_Category)

/// 设置背景颜色
/// @param color 颜色
/// @param state 状态
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

/// 根据图片位置更新图片和文字的位置
/// @param imagePosition 图片位置
- (void)updateImagePosition:(YXCButtonImagePosition)imagePosition;

@end

NS_ASSUME_NONNULL_END
