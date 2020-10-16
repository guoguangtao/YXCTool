//
//  UIControl+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIControl+YXC_Category.h"
#import <objc/runtime.h>

@interface UIControl ()

@property (nonatomic, assign) BOOL eventUnavailable; /**< 事件是否可用 */

@end

@implementation UIControl (YXC_Category)

+ (void)load {
    
    // 将系统的 sendAction:to:forEvent: 方法进行交换，拦截按钮事件
    Method system_method = class_getInstanceMethod([self class], @selector(sendAction:to:forEvent:));
    Method my_method = class_getInstanceMethod([self class], @selector(yxc_sendAction:to:forEvent:));
    method_exchangeImplementations(system_method, my_method);
}

- (void)yxc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    // 在这里只做 UIButton 的拦截
    if ([self isKindOfClass:[UIButton class]]) {
        if (self.eventUnavailable == NO) {
            self.eventUnavailable = YES;
            [self yxc_sendAction:action to:target forEvent:event];
            [self performSelector:@selector(setEventUnavailable:) withObject:@(NO) afterDelay:self.yxc_eventInterval];
        }
    } else {
        [self yxc_sendAction:action to:target forEvent:event];
    }
}

/// 设置按钮恢复事件的时长
- (void)setYxc_eventInterval:(CGFloat)yxc_eventInterval {
    
    objc_setAssociatedObject(self, @selector(yxc_eventInterval), @(yxc_eventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yxc_eventInterval {
    
    return [objc_getAssociatedObject(self, @selector(yxc_eventInterval)) floatValue];
}

/// 是否能响应事件
- (void)setEventUnavailable:(BOOL)eventUnavailable {
    
    objc_setAssociatedObject(self, @selector(eventUnavailable), @(eventUnavailable), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)eventUnavailable {
    
    return [objc_getAssociatedObject(self, @selector(eventUnavailable)) boolValue];
}


/// 设置 yxc_expandSize 的值
/// @param yxc_expandSize 需要扩大点击范围的大小
- (void)setYxc_expandSize:(CGFloat)yxc_expandSize {
    
    self.yxc_horizontalSize = yxc_expandSize;
    self.yxc_verticalSize = yxc_expandSize;
    objc_setAssociatedObject(self, @selector(setYxc_expandSize:), @(yxc_expandSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取 expandSize 值
- (CGFloat)yxc_expandSize {
    
    return [objc_getAssociatedObject(self, @selector(setYxc_expandSize:)) floatValue];
}


/// 扩大之后的范围
- (CGRect)expandRect {
    return CGRectMake(self.bounds.origin.x - self.yxc_horizontalSize,
                      self.bounds.origin.y - self.yxc_verticalSize,
                      self.bounds.size.width + 2 * self.yxc_horizontalSize,
                      self.bounds.size.height + 2 * self.yxc_verticalSize);
}

/// 设置水平方向的扩大范围
- (void)setYxc_horizontalSize:(CGFloat)yxc_horizontalSize {
    
    objc_setAssociatedObject(self, @selector(setYxc_horizontalSize:), @(yxc_horizontalSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (CGFloat)yxc_horizontalSize {
    
    return [objc_getAssociatedObject(self, @selector(setYxc_horizontalSize:)) floatValue];
}

/// 设置垂直方向的扩大范围
- (void)setYxc_verticalSize:(CGFloat)yxc_verticalSize {
    
    objc_setAssociatedObject(self, @selector(setYxc_verticalSize:), @(yxc_verticalSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yxc_verticalSize {
    
    return [objc_getAssociatedObject(self, @selector(setYxc_verticalSize:)) floatValue];
}

/// 重写父类方法
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect buttonRect = [self expandRect];
    if (CGRectEqualToRect(buttonRect, self.bounds)) {
        return [super pointInside:point
                        withEvent:event];
    }
    
    return  CGRectContainsPoint(buttonRect, point);
}

@end
