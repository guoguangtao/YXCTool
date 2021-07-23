//
//  UIView+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIView+YXC_Category.h"
#import "NSObject+YXC_Category.h"
#import "YXCToolHeader.h"
#import <objc/runtime.h>

@interface UIView ()

@property (nonatomic, strong) CALayer *topLayer; /**< 顶部边框 */
@property (nonatomic, strong) CALayer *leftLayer; /**< 左边边框 */
@property (nonatomic, strong) CALayer *rightLayer; /**< 右边边框 */
@property (nonatomic, strong) CALayer *bottomLayer; /**< 底部边框 */
@property (nonatomic, strong, readwrite) CAGradientLayer *gradientLayer; /**< 渐变色 */

@end

@implementation UIView (YXC_Category)

+ (void)load {
    
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(layoutSubviews)
                          currentSelector:@selector(yxc_view_layoutSubviews)];
}

- (void)yxc_view_layoutSubviews {
    
    [self yxc_view_layoutSubviews];
    
    [self setupBorder];
    [self setupGradientLayer];
}

- (void)setupBorder {
    
    CGFloat borderWidth = self.yxc_borderWidth > 0 ? self.yxc_borderWidth : 0;
    
    // 设置顶部边框
    if (self.yxc_border & YXCViewBorderTop) {
        CGRect frame = CGRectMake(0, 0, self.width, borderWidth);
        if (self.topLayer) {
            // 已经存在，重新设置宽度和颜色
            self.yxc_borderColor ? self.yxc_borderColor : [UIColor clearColor];
            self.topLayer.backgroundColor = self.yxc_borderColor.CGColor;
            self.topLayer.frame = frame;
        } else {
            // 不存在，创建再设置宽度和颜色
            self.topLayer = [self setupLayerWithFrame:frame];
        }
    } else {
        if (self.topLayer) {
            self.topLayer.frame = CGRectMake(0, 0, self.width, 0);
        }
    }
    
    // 设置左边边框
    if (self.yxc_border & YXCViewBorderLeft) {
        CGRect frame = CGRectMake(0, 0, borderWidth, self.height);
        if (self.leftLayer) {
            self.yxc_borderColor ? self.yxc_borderColor : [UIColor clearColor];
            self.leftLayer.backgroundColor = self.yxc_borderColor.CGColor;
            self.leftLayer.frame = frame;
        } else {
            self.leftLayer = [self setupLayerWithFrame:frame];
        }
    } else {
        if (self.leftLayer) {
            self.leftLayer.frame = CGRectMake(0, 0, 0, self.height);
        }
    }
    
    // 设置底部边框
    if (self.yxc_border & YXCViewBorderBottom) {
        CGRect frame = CGRectMake(0, self.height - borderWidth, self.width, borderWidth);
        if (self.bottomLayer) {
            self.yxc_borderColor ? self.yxc_borderColor : [UIColor clearColor];
            self.bottomLayer.backgroundColor = self.yxc_borderColor.CGColor;
            self.bottomLayer.frame = frame;
        } else {
            self.bottomLayer = [self setupLayerWithFrame:frame];
        }
    } else {
        if (self.bottomLayer) {
            self.bottomLayer.frame = CGRectMake(0, self.height - borderWidth, self.width, 0);
        }
    }
    
    // 设置右边边框
    if (self.yxc_border & YXCViewBorderRight) {
        CGRect frame = CGRectMake(self.width - borderWidth, 0, borderWidth, self.height);
        if (self.rightLayer) {
            self.yxc_borderColor ? self.yxc_borderColor : [UIColor clearColor];
            self.rightLayer.backgroundColor = self.yxc_borderColor.CGColor;
            self.rightLayer.frame = frame;
        } else {
            self.rightLayer = [self setupLayerWithFrame:frame];
        }
    } else {
        if (self.rightLayer) {
            self.rightLayer.frame = CGRectMake(self.width - borderWidth, 0, 0, self.height);
        }
    }
}

- (CALayer *)setupLayerWithFrame:(CGRect)frame {
    
    // 设置边框
    CALayer *layer = [[CALayer alloc] init];
    layer.frame = frame;
    UIColor *color = self.yxc_borderColor ? self.yxc_borderColor : [UIColor clearColor];
    layer.backgroundColor = color.CGColor;
    [self.layer addSublayer:layer];
    
    return layer;
}

/// 设置渐变色
- (void)setupGradientLayer {
    
    if (self.yxc_colors) {
        // 设置渐变色
        if (self.gradientLayer == nil) {
            self.gradientLayer = [CAGradientLayer new];
            [self.layer insertSublayer:self.gradientLayer atIndex:0];
        }
        self.gradientLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
        self.gradientLayer.colors = self.yxc_colors;
        self.gradientLayer.startPoint = self.yxc_startPoint;
        if (CGPointEqualToPoint(self.yxc_endPoint, CGPointMake(0, 0))) {
            self.yxc_endPoint = CGPointMake(0, 1);
        }
        self.gradientLayer.endPoint = self.yxc_endPoint;
        if (self.yxc_locations) {
            self.gradientLayer.locations = self.yxc_locations;
        }
    }
}


#pragma mark - topLayer

- (void)setTopLayer:(CALayer *)topLayer {
    
    objc_setAssociatedObject(self, @selector(topLayer), topLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)topLayer {
    
    return objc_getAssociatedObject(self, @selector(topLayer));
}

#pragma mark - leftLayer

- (void)setLeftLayer:(CALayer *)leftLayer {
    
    objc_setAssociatedObject(self, @selector(leftLayer), leftLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)leftLayer {
    
    return objc_getAssociatedObject(self, @selector(leftLayer));
}

#pragma mark - rightLayer

- (void)setRightLayer:(CALayer *)rightLayer {
    
    objc_setAssociatedObject(self, @selector(rightLayer), rightLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)rightLayer {
    
    return objc_getAssociatedObject(self, @selector(rightLayer));
}

#pragma mark - bottomLayer

- (void)setBottomLayer:(CALayer *)bottomLayer {
    
    objc_setAssociatedObject(self, @selector(bottomLayer), bottomLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CALayer *)bottomLayer {
    
    return objc_getAssociatedObject(self, @selector(bottomLayer));
}

#pragma mark - yxc_borderColor

- (void)setYxc_borderColor:(UIColor *)yxc_borderColor {
    
    objc_setAssociatedObject(self, @selector(yxc_borderColor), yxc_borderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupBorder];
}

- (UIColor *)yxc_borderColor {
    
    return objc_getAssociatedObject(self, @selector(yxc_borderColor));
}

#pragma mark - yxc_cornerRadius

- (void)setYxc_cornerRadius:(CGFloat)yxc_cornerRadius {
    
    objc_setAssociatedObject(self, @selector(yxc_cornerRadius), @(yxc_cornerRadius), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)yxc_cornerRadius {
    
    return [objc_getAssociatedObject(self, @selector(yxc_cornerRadius)) floatValue];
}

#pragma mark - yxc_border

- (void)setYxc_border:(YXCViewBorder)yxc_border {
    
    objc_setAssociatedObject(self, @selector(yxc_border), [NSNumber numberWithUnsignedInteger:yxc_border], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupBorder];
}

- (YXCViewBorder)yxc_border {
    
    return [objc_getAssociatedObject(self, @selector(yxc_border)) unsignedIntegerValue];
}

#pragma mark - yxc_borderWidth

- (void)setYxc_borderWidth:(CGFloat)yxc_borderWidth {
    
    objc_setAssociatedObject(self, @selector(yxc_borderWidth), [NSNumber numberWithFloat:yxc_borderWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setupBorder];
}

- (CGFloat)yxc_borderWidth {
    
    return [objc_getAssociatedObject(self, @selector(yxc_borderWidth)) floatValue];
}

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

#pragma mark - top

/// UIView top Setter 方法
/// @param top 顶部距离父视图的值
- (void)setTop:(CGFloat)top {
    CGRect temp = self.frame;
    temp.origin.y = top;
    self.frame = temp;
}

/// 顶部距离父视图的值
- (CGFloat)top {
    
    return self.frame.origin.y;
}

#pragma mark - left

- (void)setLeft:(CGFloat)left {
    
    CGRect temp = self.frame;
    temp.origin.x = left;
    self.frame = temp;
}

- (CGFloat)left {
    
    return self.frame.origin.x;
}


#pragma mark - bottom

- (void)setBottom:(CGFloat)bottom {
    
    CGRect temp = self.frame;
    CGFloat height = temp.size.height;
    temp.origin.y = bottom - height;
    self.frame = temp;
}

- (CGFloat)bottom {
    
    return CGRectGetMaxY(self.frame);
}


#pragma mark - right

- (void)setRight:(CGFloat)right {
    
    CGRect temp = self.frame;
    CGFloat width = temp.size.width;
    temp.origin.x = right - width;
    self.frame = temp;
}

- (CGFloat)right {
    
    return CGRectGetMaxX(self.frame);
}

/// 设置渐变色开始位置
- (void)setYxc_startPoint:(CGPoint)yxc_startPoint {
    
    NSString *startPoint = NSStringFromCGPoint(yxc_startPoint);
    objc_setAssociatedObject(self, @selector(yxc_startPoint), startPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取渐变色开始位置
- (CGPoint)yxc_startPoint {
    
    NSString *startPoint = objc_getAssociatedObject(self, @selector(yxc_startPoint));
    return CGPointFromString(startPoint);
}

/// 设置渐变色结束位置
- (void)setYxc_endPoint:(CGPoint)yxc_endPoint {
    
    NSString *endPoint = NSStringFromCGPoint(yxc_endPoint);
    objc_setAssociatedObject(self, @selector(yxc_endPoint), endPoint, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取渐变色结束位置
- (CGPoint)yxc_endPoint {
    
    NSString *endPoint = objc_getAssociatedObject(self, @selector(yxc_endPoint));
    return CGPointFromString(endPoint);
}

/// 设置渐变色数组
- (void)setYxc_colors:(NSArray *)yxc_colors {
    
    objc_setAssociatedObject(self, @selector(yxc_colors), yxc_colors, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取渐变色数组
- (NSArray *)yxc_colors {
    
    return objc_getAssociatedObject(self, @selector(yxc_colors));
}

/// 设置渐变色 Layer
- (void)setGradientLayer:(CAGradientLayer *)gradientLayer {
    
    objc_setAssociatedObject(self, @selector(gradientLayer), gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取渐变色 Layer
- (CAGradientLayer *)gradientLayer {
    
    return objc_getAssociatedObject(self, @selector(gradientLayer));
}

/// 设置渐变色位置
- (void)setYxc_locations:(NSArray<NSNumber *> *)yxc_locations {
    
    objc_setAssociatedObject(self, @selector(yxc_locations), yxc_locations, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取渐变色位置
- (NSArray<NSNumber *> *)yxc_locations {
    
    return objc_getAssociatedObject(self, @selector(yxc_locations));
}

#pragma mark - 移除所有子视图

- (void)yxc_removeAllSubView {
    
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark - 将视图保存到相册中去

/// 将图片保存到相册中
- (void)saveToAlbum {
    
    UIImage *image = [self convertViewToImage];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.frame = CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT);
    image = [imageView convertViewToImage];
    if (image != nil) {
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

/// 图片保存成功回调
/// @param image 需要保存的图片
/// @param error 错误信息
/// @param contextInfo context 信息
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
    YXCLog(@"图片保存成功");
}

/// 将当前 view 转成 图片
- (UIImage *)convertViewToImage {
    
    UIImage *imageRet = [[UIImage alloc]init];
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}

- (void)yxc_setBackgroundImage:(UIImage *)image {
    UIGraphicsBeginImageContext(self.frame.size);
    [image drawInRect:self.bounds];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    self.backgroundColor = [UIColor colorWithPatternImage:bgImage];
}

@end
