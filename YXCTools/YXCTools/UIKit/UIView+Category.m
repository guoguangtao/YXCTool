//
//  UIView+Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIView+Category.h"

@implementation UIView (Category)

#pragma mark - X 坐标值的重写方法

/**
 *  UIView X Setter 方法
 */
- (void)setX:(CGFloat)x {
    CGRect temp = self.frame;
    temp.origin.x = x;
    self.frame = temp;
}

/**
 *  UIView X Getter 方法
 */
- (CGFloat)x {
    return self.frame.origin.x;
}

#pragma mark - Y 坐标值的重写方法

/**
 *  UIView Y Setter 方法
 */
- (void)setY:(CGFloat)y {
    CGRect temp = self.frame;
    temp.origin.y = y;
    self.frame = temp;
}

/**
 *  UIView Y Getter 方法
 */
- (CGFloat)y {
    return self.frame.origin.y;
}

#pragma mark - Width 坐标值的重写方法

/**
 *  UIView Width Setter 方法
 */
- (void)setWidth:(CGFloat)width {
    CGRect temp = self.frame;
    temp.size.width = width;
    self.frame = temp;
}

/**
 *  UIView Width Getter 方法
 */
- (CGFloat)width {
    return self.frame.size.width;
}

#pragma mark - Height 坐标值的重写方法

/**
 *  UIView Height Setter 方法
 */
- (void)setHeight:(CGFloat)height {
    CGRect temp = self.frame;
    temp.size.height = height;
    self.frame = temp;
}


/**
 *  UIView Height Getter 方法
 */
- (CGFloat)height {
    return self.frame.size.height;
}

#pragma mark - Size 坐标值的重写方法

/**
 *  UIView Size Setter 方法
 */
- (void)setSize:(CGSize)size {
    CGRect temp = self.frame;
    temp.size = size;
    self.frame = temp;
}


/**
 *  UIView Size Getter 方法
 */
- (CGSize)size {
    return self.frame.size;
}

#pragma mark - Origin 坐标值的重写方法

/**
 *  UIView Origin Setter 方法
 */
- (void)setOrigin:(CGPoint)origin {
    CGRect temp = self.frame;
    temp.origin = origin;
    self.frame = temp;
}


/**
 *  UIView Origin Getter 方法
 */
- (CGPoint)origin {
    return self.frame.origin;
}

#pragma mark - CenterX 坐标值的重写方法

/**
 *  UIView CenterX Setter 方法
 */
- (void)setCenterX:(CGFloat)centerX {
    CGPoint temp = self.center;
    temp.x = centerX;
    self.center = temp;
}


/**
 *  UIView CenterX Getter 方法
 */
- (CGFloat)centerX {
    return self.center.x;
}

#pragma mark - CenterY 坐标值的重写方法

/**
 *  UIView CenterY Setter 方法
 */
- (void)setCenterY:(CGFloat)centerY {
    CGPoint temp = self.center;
    temp.y = centerY;
    self.center = temp;
}


/**
 *  UIView CenterY Getter 方法
 */
- (CGFloat)centerY {
    return self.center.y;
}

#pragma mark - 移除所有子视图

- (void)yxc_removeAllSubView {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

@end
