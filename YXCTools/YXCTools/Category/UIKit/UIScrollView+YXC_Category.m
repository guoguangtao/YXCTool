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
    offset.x = [self computeWithTimingFunction:self.timingFunction t:self.runTime b:self.startOffset.x c:self.destinationOffset.x - self.startOffset.x d:self.duration];
    offset.y = [self computeWithTimingFunction:self.timingFunction t:self.runTime b:self.startOffset.y c:self.destinationOffset.y - self.startOffset.y d:self.duration];
    [self.scrollView setContentOffset:offset animated:NO];
}

- (CGFloat)computeWithTimingFunction:(YXCScrollTimingFunction)timingFunction t:(CGFloat)t b:(CGFloat)b c:(CGFloat)c d:(CGFloat)d {
    
    switch (timingFunction) {
        case YXCScrollTimingFunctionLinear: {
            return c * t / d + b;
        } break;
        case YXCScrollTimingFunctionQuadIn: {
            t /= d;
            return c * t * t + b;
        } break;
        case YXCScrollTimingFunctionQuadOut: {
            t /= d;
            return -c * t * (t - 2) + b;
        } break;
        case YXCScrollTimingFunctionQuadInOut: {
            t /= d / 2;
            if (t < 1) {
                return c / 2 * t * t + b;
            }
            t -= 1;
            return -c / 2 * (t * (t - 2) - 1) + b;
        } break;
        case YXCScrollTimingFunctionCubicIn: {
            t /= d;
            return c * t * t * t + b;
        } break;
        case YXCScrollTimingFunctionCubicOut: {
            t = t / d - 1;
            return c * (t * t * t + 1) + b;
        } break;
        case YXCScrollTimingFunctionCubicInOut: {
            t /= d / 2;
            if (t < 1) {
                return c / 2 * t * t * t + b;
            }
            t -= 2;
            return c / 2 * (t * t * t + 2) + b;
        } break;
        case YXCScrollTimingFunctionQuartIn: {
            t /= d;
            return c * t * t * t * t + b;
        } break;
        case YXCScrollTimingFunctionQuartOut: {
            t = t / d - 1;
            return -c * (t * t * t * t - 1) + b;
        } break;
        case YXCScrollTimingFunctionQuartInOut: {
            t /= d / 2;
            if (t < 1) {
                return c / 2 * t * t * t * t + b;
            }
            t -= 2;
            return -c / 2 * (t * t * t * t - 2) + b;
        } break;
        case YXCScrollTimingFunctionQuintIn: {
            t /= d;
            return c * t * t * t * t * t + b;
        } break;
        case YXCScrollTimingFunctionQuintOut: {
            t = t / d - 1;
            return c * ( t * t * t * t * t + 1) + b;
        } break;
        case YXCScrollTimingFunctionQuintInOut: {
            t /= d / 2;
            if (t < 1) {
                return c / 2 * t * t * t * t * t + b;
            }
            t -= 2;
            return c / 2 * (t * t * t * t * t + 2) + b;
        } break;
        case YXCScrollTimingFunctionSineIn: {
            return -c * cos(t / d * (self.pi / 2)) + c + b;
        } break;
        case YXCScrollTimingFunctionSineOut: {
            return c * sin(t / d * (self.pi / 2)) + b;
        } break;
        case YXCScrollTimingFunctionSineInOut: {
            return -c / 2 * (cos(self.pi * t / d) - 1) + b;
        } break;
        case YXCScrollTimingFunctionExpoIn: {
            return (t == 0) ? b : c * pow(2, 10 * (t / d - 1)) + b;
        } break;
        case YXCScrollTimingFunctionExpoOut: {
            return (t == d) ? b + c : c * (-pow(2, -10 * t / d) + 1) + b;
        } break;
        case YXCScrollTimingFunctionExpoInOut: {
            if (t == 0) {
                return b;
            }
            if (t == d) {
                return b + c;
            }
            t /= d / 2;
            if (t < 1) {
                return c / 2 * pow(2, 10 * (t - 1)) + b;
            }
            t -= 1;
            return c / 2 * (-pow(2, -10 * t) + 2) + b;
        } break;
        case YXCScrollTimingFunctionCircleIn: {
            t /= d;
            return -c * (sqrt(1 - t * t) - 1) + b;
        } break;
        case YXCScrollTimingFunctionCircleOut: {
            t = t / d - 1;
            return c * sqrt(1 - t * t) + b;
        } break;
        case YXCScrollTimingFunctionCircleInOut: {
            t /= d / 2;
            if (t < 1) {
                return -c / 2 * (sqrt(1 - t * t) - 1) + b;
            }
            t -= 2;
            return c / 2 * (sqrt(1 - t * t) + 1) + b;
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
- (void)ycx_setContentOffset:(CGPoint)contentOffset duration:(NSTimeInterval)duration timingFunction:(YXCScrollTimingFunction)timingFunction completion:(dispatch_block_t _Nullable)completion {
    
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
