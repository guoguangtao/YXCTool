//
//  UIScrollView+YXC_Category.h
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YXCScrollTimingFunction) {
    YXCScrollTimingFunctionLinear,
    YXCScrollTimingFunctionQuadIn,
    YXCScrollTimingFunctionQuadOut,
    YXCScrollTimingFunctionQuadInOut,
    YXCScrollTimingFunctionCubicIn,
    YXCScrollTimingFunctionCubicOut,
    YXCScrollTimingFunctionCubicInOut,
    YXCScrollTimingFunctionQuartIn,
    YXCScrollTimingFunctionQuartOut,
    YXCScrollTimingFunctionQuartInOut,
    YXCScrollTimingFunctionQuintIn,
    YXCScrollTimingFunctionQuintOut,
    YXCScrollTimingFunctionQuintInOut,
    YXCScrollTimingFunctionSineIn,
    YXCScrollTimingFunctionSineOut,
    YXCScrollTimingFunctionSineInOut,
    YXCScrollTimingFunctionExpoIn,
    YXCScrollTimingFunctionExpoOut,
    YXCScrollTimingFunctionExpoInOut,
    YXCScrollTimingFunctionCircleIn,
    YXCScrollTimingFunctionCircleOut,
    YXCScrollTimingFunctionCircleInOut,
};

NS_ASSUME_NONNULL_BEGIN

/// ScrollView 分类
@interface UIScrollView (YXC_Category)

/// 设置 UIScrollView 的偏移量
/// @param contentOffset 偏移量
/// @param duration 动画时长
/// @param timingFunction 动画样式
/// @param completion 完成回调
- (void)yxc_setContentOffset:(CGPoint)contentOffset duration:(NSTimeInterval)duration timingFunction:(YXCScrollTimingFunction)timingFunction completion:(dispatch_block_t _Nullable)completion;

@end

NS_ASSUME_NONNULL_END
