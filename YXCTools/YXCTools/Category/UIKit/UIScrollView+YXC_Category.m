//
//  UIScrollView+YXC_Category.m
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "UIScrollView+YXC_Category.h"
#import <objc/runtime.h>

#pragma mark - ================== YXCScrollViewAnimator ==================


/// 动画管理类
@interface YXCScrollViewAnimator : NSObject

@property (nonatomic, copy) dispatch_block_t completion;

+ (instancetype)animatorWithScrollView:(UIScrollView *)scrollView timingFunction:(YXCScrollTimingFunction)timingFunction;

- (instancetype)initWithScrollView:(UIScrollView *)scrollView timingFunction:(YXCScrollTimingFunction)timingFunction;

- (void)setContentOffset:(CGPoint)contentOffset duration:(NSTimeInterval)duration;

@end

@interface YXCScrollViewAnimator ()

@property (nonatomic, weak) UIScrollView *scrollView;   /**< ScrollView */
@property (nonatomic, assign) YXCScrollTimingFunction timingFunction;   /**< 动画样式 */
@property (nonatomic, assign) NSTimeInterval startTime; /**< 动画开始时间 */
@property (nonatomic, assign) CGPoint startOffset;  /**< 开始偏移量 */
@property (nonatomic, assign) CGPoint destinationOffset;    /**< 最终偏移量 */
@property (nonatomic, assign) NSTimeInterval duration;  /**< 动画时长 */
@property (nonatomic, assign) NSTimeInterval runTime;
@property (nonatomic, strong) CADisplayLink *timer;
@property (nonatomic, assign) CGFloat pi;       /**< π */

@end

@implementation YXCScrollViewAnimator

+ (instancetype)animatorWithScrollView:(UIScrollView *)scrollView timingFunction:(YXCScrollTimingFunction)timingFunction {
    
    return [[self alloc] initWithScrollView:scrollView timingFunction:timingFunction];
}

- (instancetype)initWithScrollView:(UIScrollView *)scrollView timingFunction:(YXCScrollTimingFunction)timingFunction {
    
    if (self = [super init]) {
        
        self.scrollView = scrollView;
        self.timingFunction = timingFunction;
        self.startTime = 0;
        self.duration = 0.25;
        self.runTime = 0;
        self.pi = 3.14159265358979;
    }
    
    return self;
}

- (void)setContentOffset:(CGPoint)contentOffset duration:(NSTimeInterval)duration {
    
    if (self.scrollView == nil) {
        return;
    }
    
    self.startTime = [NSDate date].timeIntervalSince1970;
    self.startOffset = self.scrollView.contentOffset;
    self.destinationOffset = contentOffset;
    self.duration = duration;
    self.runTime = 0;
    
    if (self.duration <= 0) {
        [self.scrollView setContentOffset:contentOffset animated:NO];
    }
    
    if (self.timer == nil) {
        self.timer = [CADisplayLink displayLinkWithTarget:self selector:@selector(animtedScroll)];
        [self.timer addToRunLoop:NSRunLoop.mainRunLoop forMode:NSRunLoopCommonModes];
    }
}

- (void)animtedScroll {
    
    if (self.timer == nil) {
        return;
    }
    
    if (self.scrollView == nil) {
        return;
    }
    
    self.runTime += self.timer.duration;
    if (self.runTime >= self.duration) {
        [self.scrollView setContentOffset:self.destinationOffset animated:NO];
        [self.timer invalidate];
        self.timer = nil;
        self.completion ? self.completion() : nil;
        return;
    }
    
    CGPoint offset = self.scrollView.contentOffset;
    offset.x = [self computeWithTimingFunction:self.timingFunction
                                       runTime:self.runTime
                                   startOffset:self.startOffset.x
                                        offset:self.destinationOffset.x - self.startOffset.x
                                      duration:self.duration];
    offset.y = [self computeWithTimingFunction:self.timingFunction
                                       runTime:self.runTime
                                   startOffset:self.startOffset.y
                                        offset:self.destinationOffset.y - self.startOffset.y
                                      duration:self.duration];
    [self.scrollView setContentOffset:offset animated:NO];
}

/// 计算偏移量
/// @param timingFunction 当前动画模式
/// @param runTime 当前 runTime
/// @param startOffset 一开始滚动的偏移量
/// @param offset 需要滚动多少范围 = 最终偏移量 - 一开始的偏移量
/// @param duration 动画时长
- (CGFloat)computeWithTimingFunction:(YXCScrollTimingFunction)timingFunction
                             runTime:(CGFloat)runTime
                         startOffset:(CGFloat)startOffset
                              offset:(CGFloat)offset duration:(CGFloat)duration {
    
    switch (timingFunction) {
        case YXCScrollTimingFunctionLinear: {
            return offset * runTime / duration + startOffset;
        } break;
        case YXCScrollTimingFunctionQuadIn: {
            runTime /= duration;
            return offset * runTime * runTime + startOffset;
        } break;
        case YXCScrollTimingFunctionQuadOut: {
            runTime /= duration;
            return -offset * runTime * (runTime - 2) + startOffset;
        } break;
        case YXCScrollTimingFunctionQuadInOut: {
            runTime /= duration / 2;
            if (runTime < 1) {
                return offset / 2 * runTime * runTime + startOffset;
            }
            runTime -= 1;
            return -offset / 2 * (runTime * (runTime - 2) - 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionCubicIn: {
            runTime /= duration;
            return offset * runTime * runTime * runTime + startOffset;
        } break;
        case YXCScrollTimingFunctionCubicOut: {
            runTime = runTime / duration - 1;
            return offset * (runTime * runTime * runTime + 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionCubicInOut: {
            runTime /= duration / 2;
            if (runTime < 1) {
                return offset / 2 * runTime * runTime * runTime + startOffset;
            }
            runTime -= 2;
            return offset / 2 * (runTime * runTime * runTime + 2) + startOffset;
        } break;
        case YXCScrollTimingFunctionQuartIn: {
            runTime /= duration;
            return offset * runTime * runTime * runTime * runTime + startOffset;
        } break;
        case YXCScrollTimingFunctionQuartOut: {
            runTime = runTime / duration - 1;
            return -offset * (runTime * runTime * runTime * runTime - 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionQuartInOut: {
            runTime /= duration / 2;
            if (runTime < 1) {
                return offset / 2 * runTime * runTime * runTime * runTime + startOffset;
            }
            runTime -= 2;
            return -offset / 2 * (runTime * runTime * runTime * runTime - 2) + startOffset;
        } break;
        case YXCScrollTimingFunctionQuintIn: {
            runTime /= duration;
            return offset * runTime * runTime * runTime * runTime * runTime + startOffset;
        } break;
        case YXCScrollTimingFunctionQuintOut: {
            runTime = runTime / duration - 1;
            return offset * ( runTime * runTime * runTime * runTime * runTime + 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionQuintInOut: {
            runTime /= duration / 2;
            if (runTime < 1) {
                return offset / 2 * runTime * runTime * runTime * runTime * runTime + startOffset;
            }
            runTime -= 2;
            return offset / 2 * (runTime * runTime * runTime * runTime * runTime + 2) + startOffset;
        } break;
        case YXCScrollTimingFunctionSineIn: {
            return -offset * cos(runTime / duration * (self.pi / 2)) + offset + startOffset;
        } break;
        case YXCScrollTimingFunctionSineOut: {
            return offset * sin(runTime / duration * (self.pi / 2)) + startOffset;
        } break;
        case YXCScrollTimingFunctionSineInOut: {
            return -offset / 2 * (cos(self.pi * runTime / duration) - 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionExpoIn: {
            return (runTime == 0) ? startOffset : offset * pow(2, 10 * (runTime / duration - 1)) + startOffset;
        } break;
        case YXCScrollTimingFunctionExpoOut: {
            return (runTime == duration) ? startOffset + offset : offset * (-pow(2, -10 * runTime / duration) + 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionExpoInOut: {
            if (runTime == 0) {
                return startOffset;
            }
            if (runTime == duration) {
                return startOffset + offset;
            }
            runTime /= duration / 2;
            if (runTime < 1) {
                return offset / 2 * pow(2, 10 * (runTime - 1)) + startOffset;
            }
            runTime -= 1;
            return offset / 2 * (-pow(2, -10 * runTime) + 2) + startOffset;
        } break;
        case YXCScrollTimingFunctionCircleIn: {
            runTime /= duration;
            return -offset * (sqrt(1 - runTime * runTime) - 1) + startOffset;
        } break;
        case YXCScrollTimingFunctionCircleOut: {
            runTime = runTime / duration - 1;
            return offset * sqrt(1 - runTime * runTime) + startOffset;
        } break;
        case YXCScrollTimingFunctionCircleInOut: {
            runTime /= duration / 2;
            if (runTime < 1) {
                return -offset / 2 * (sqrt(1 - runTime * runTime) - 1) + startOffset;
            }
            runTime -= 2;
            return offset / 2 * (sqrt(1 - runTime * runTime) + 1) + startOffset;
        } break;
    }
}

@end

#pragma mark - ================== UIScrollView 分类 ==================

@interface UIScrollView ()

@property (nonatomic, strong) YXCScrollViewAnimator *yxc_animator; /**< 动画管理类 */

@end

@implementation UIScrollView (YXC_Category)

- (void)setYxc_animator:(YXCScrollViewAnimator *)yxc_animator {
    
    objc_setAssociatedObject(self, @selector(yxc_animator), yxc_animator, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (YXCScrollViewAnimator *)yxc_animator {
    
    return objc_getAssociatedObject(self, @selector(yxc_animator));
}


/// 设置 UIScrollView 的偏移量
/// @param contentOffset 偏移量
/// @param duration 动画时长
/// @param timingFunction 动画样式
/// @param completion 完成回调
- (void)yxc_setContentOffset:(CGPoint)contentOffset
                    duration:(NSTimeInterval)duration
              timingFunction:(YXCScrollTimingFunction)timingFunction
                  completion:(dispatch_block_t _Nullable)completion {
    
    if (self.yxc_animator == nil) {
        self.yxc_animator = [YXCScrollViewAnimator animatorWithScrollView:self timingFunction:timingFunction];
    }
    
    self.yxc_animator.completion = ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            completion ? completion() : nil;
        });
    };
    [self.yxc_animator setContentOffset:contentOffset duration:duration];
}

@end
