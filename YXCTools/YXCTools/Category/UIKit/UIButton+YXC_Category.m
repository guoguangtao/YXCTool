//
//  UIButton+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIButton+YXC_Category.h"
#import "UIImage+YXC_Category.h"
#import "NSObject+YXC_Category.h"
#import "UIView+YXC_Category.h"
#import "UIControl+YXC_Category.h"
#import <objc/runtime.h>

@interface UIButton ()

@property (nonatomic, assign, readwrite) CGSize yxc_buttonSize;      /**< 最终按钮的最适合 size */
@property (nonatomic, strong) CAGradientLayer *gradientLayer;       /**< 渐变色 */

@end

@implementation UIButton (YXC_Category)

+ (void)load {
    
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(layoutSubviews)
                          currentSelector:@selector(yxc_button_layoutSubviews)];
}

- (void)yxc_button_layoutSubviews {
    [self yxc_button_layoutSubviews];
    
    [self setupGradientLayer];
    
    switch (self.yxc_imagePosition) {
        case YXCButtomImageLeft: [self setupImageLeft]; break;
        case YXCButtomImageBottom: [self setupImageBottom]; break;
        case YXCButtomImageRight: [self setupImageRight]; break;
        case YXCButtomImageTop: [self setupImageTop]; break;
    }
}

/// 设置图片居上
- (void)setupImageTop {
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGFloat height = self.imageView.height + self.yxc_imageTitleSpace + self.titleLabel.height;
    
    // 设置图片位置
    self.imageView.centerX = self.width * 0.5f;
    self.imageView.y = (self.height - height) * 0.5f;
    [self.imageView sizeToFit];
    
    // 设置文字位置
    self.titleLabel.centerX = self.width * 0.5f;
    self.titleLabel.y = self.imageView.bottom + self.yxc_imageTitleSpace;
    [self.titleLabel sizeToFit];
    
    CGFloat width = MAX(self.imageView.width, self.titleLabel.width);
    self.yxc_buttonSize = CGSizeMake(width, height);
}

/// 设置图片居左
- (void)setupImageLeft {
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGFloat width = self.imageView.width + self.yxc_imageTitleSpace + self.titleLabel.width;
    
    self.imageView.x = (self.width - width) * 0.5f;
    [self.imageView sizeToFit];
    
    self.titleLabel.x = self.imageView.right + self.yxc_imageTitleSpace;
    [self.titleLabel sizeToFit];
    
    CGFloat height = MAX(self.imageView.height, self.titleLabel.height);
    self.yxc_buttonSize = CGSizeMake(width, height);
}

/// 设置图片居下
- (void)setupImageBottom {
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGFloat height = self.imageView.height + self.yxc_imageTitleSpace + self.titleLabel.height;
    
    self.titleLabel.centerX = self.width * 0.5f;
    self.titleLabel.y = (self.height - height) * 0.5f;
    [self.titleLabel sizeToFit];
    
    self.imageView.centerX = self.width * 0.5f;
    self.imageView.y = self.titleLabel.bottom + self.yxc_imageTitleSpace;
    [self.imageView sizeToFit];
    
    CGFloat width = MAX(self.imageView.width, self.titleLabel.width);
    self.yxc_buttonSize = CGSizeMake(width, height);
}

/// 设置图片居右
- (void)setupImageRight {
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGFloat width = self.imageView.width + self.yxc_imageTitleSpace + self.titleLabel.width;
    
    self.titleLabel.x = (self.width - width) * 0.5f;
    [self.titleLabel sizeToFit];
    
    self.imageView.x = self.titleLabel.right + self.yxc_imageTitleSpace;
    [self.imageView sizeToFit];
    
    CGFloat height = MAX(self.imageView.height, self.titleLabel.height);
    self.yxc_buttonSize = CGSizeMake(width, height);
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
    
    [self setImage:[UIImage imageNamed:imageName] forState:state];
}

/// 设置图片和文字间距
/// @param yxc_imageTitleSpace 图片与文字的间距
- (void)setYxc_imageTitleSpace:(CGFloat)yxc_imageTitleSpace {
    
    objc_setAssociatedObject(self, @selector(yxc_imageTitleSpace), @(yxc_imageTitleSpace), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取图片与文字的间距
- (CGFloat)yxc_imageTitleSpace {
    
    return [objc_getAssociatedObject(self, @selector(yxc_imageTitleSpace)) floatValue];
}

/// 设置图片位置
/// @param yxc_imagePosition 图片位置
- (void)setYxc_imagePosition:(YXCButtomImage)yxc_imagePosition {
    
    objc_setAssociatedObject(self, @selector(yxc_imagePosition), @(yxc_imagePosition), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取图片位置
- (YXCButtomImage)yxc_imagePosition {
    
    return [objc_getAssociatedObject(self, @selector(yxc_imagePosition)) integerValue];
}

/// 设置按钮的实际大小
/// @param yxc_buttonSize 按钮的实际 size
- (void)setYxc_buttonSize:(CGSize)yxc_buttonSize {
    
    objc_setAssociatedObject(self, @selector(yxc_buttonSize), NSStringFromCGSize(yxc_buttonSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

/// 获取按钮的实际 size
- (CGSize)yxc_buttonSize {
    
    NSString *sizeString = objc_getAssociatedObject(self, @selector(yxc_buttonSize));
    CGSize size = CGSizeFromString(sizeString);
    return size;
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

/// 更新按钮size
- (void)yxc_sizeToFit {
    
    CGPoint center = self.center;
    self.size = self.yxc_buttonSize;
    self.center = center;
}

#pragma mark - 链式编程函数

/// 设置标题
- (UIButton * _Nonnull (^)(NSString * _Nonnull, UIControlState))yxc_setTitle {
    
    return ^(NSString *title, UIControlState state){
        [self setTitle:title forState:state];
        return self;
    };
}

/// 设置背景颜色
- (UIButton * _Nonnull (^)(UIColor * _Nonnull, UIControlState))yxc_setBackgroundColor {
    
    return ^(UIColor *color, UIControlState state){
        [self setBackgroundColor:color forState:state];
        return self;
    };
}

/// 设置文字颜色
- (UIButton * _Nonnull (^)(UIColor * _Nonnull, UIControlState))yxc_setTitleColor {
    
    return ^(UIColor *color, UIControlState state){
        [self setTitleColor:color forState:state];
        return self;
    };
}

/// 设置图片
- (UIButton * _Nonnull (^)(NSString * _Nonnull, UIControlState))yxc_setImageName {
    
    return ^(NSString *imageName, UIControlState state){
        [self yxc_setImage:imageName forState:state];
        return self;
    };
}

/// 设置图片
- (UIButton * _Nonnull (^)(UIImage * _Nonnull, UIControlState))yxc_setImage {
    
    return ^(UIImage *image, UIControlState state) {
        [self setImage:image forState:UIControlStateNormal];
        return self;
    };
}

/// 设置背景图片
- (UIButton * _Nonnull (^)(UIImage * _Nonnull, UIControlState))yxc_setBackgroundImage {
    
    return ^(UIImage *image, UIControlState state) {
        [self setBackgroundImage:image forState:state];
        return self;
    };
}

/// 设置背景图片
- (UIButton * _Nonnull (^)(NSString * _Nonnull, UIControlState))yxc_setBackgroundImageName {
    
    return ^(NSString *imageName, UIControlState state) {
        if ([imageName checkString]) {
            [self setBackgroundImage:[UIImage imageNamed:imageName] forState:state];            
        }
        return self;
    };
}

/// 设置图片的位置
- (UIButton * _Nonnull (^)(YXCButtomImage))yxc_setImagePosition {
    
    return ^(YXCButtomImage imagePosition){
        self.yxc_imagePosition = imagePosition;
        return self;
    };
}

/// 设置图片和文字之间的间距
- (UIButton * _Nonnull (^)(CGFloat))yxc_setImageTitleSpace {
    
    return ^(CGFloat imageTitleSpace){
        self.yxc_imageTitleSpace = imageTitleSpace;
        return self;
    };
}

/// 添加事件
- (UIButton * _Nonnull (^)(id _Nonnull, SEL _Nonnull, UIControlEvents))yxc_addAction {
    
    return ^(id target, SEL action, UIControlEvents controlEvents){
        [self addTarget:target action:action forControlEvents:controlEvents];
        return self;
    };
}

/// 设置系统字体大小
- (UIButton * _Nonnull (^)(CGFloat, UIFontWeight))yxc_setFont {
    
    return ^(CGFloat fontSize, UIFontWeight weight){
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize weight:weight];
        return self;
    };
}

/// 设置系统字体大小
- (UIButton * _Nonnull (^)(UIFont * _Nonnull))yxc_setSystemFontOfSize {
    
    return ^(UIFont *font){
        self.titleLabel.font = font;
        return self;
    };
}

/// 设置系统字体大小
- (UIButton * _Nonnull (^)(CGFloat))yxc_setFontSize {
    
    return ^(CGFloat fontSize){
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

/// 设置防止重复点击时长
- (UIButton * _Nonnull (^)(CGFloat))yxc_setEventInterval {
    
    return ^(CGFloat eventInterval) {
        self.yxc_eventInterval = eventInterval;
        return self;
    };
}

/// 添加到父视图
- (UIButton * _Nonnull (^)(UIView * _Nonnull))yxc_addForSuperView {
    
    return ^(UIView *superView){
        if (superView) {
            [superView addSubview:self];
        }
        return self;
    };
}

/// 设置 Tag
- (UIButton *(^)(NSInteger tag))yxc_setTag {
    
    return ^(NSInteger tag) {
        self.tag = tag;
        return self;
    };
}

/// 设置圆角
- (UIButton *(^)(CGFloat cornerRadius))yxc_setCornerRadius {
    
    return ^(CGFloat cornerRadius) {
        self.layer.cornerRadius = cornerRadius;
        self.layer.masksToBounds = YES;
        return self;
    };
}

/// 设置边框
- (UIButton *(^)(UIColor *borderColor, CGFloat borderWidth))yxc_setBorder {
    
    return ^(UIColor *borderColor, CGFloat borderWidth) {
        self.layer.borderColor = borderColor.CGColor;
        self.layer.borderWidth = borderWidth;
        return self;
    };
}

/// 设置 Frame
- (UIButton *(^)(CGFloat x, CGFloat y, CGFloat width, CGFloat height))yxc_setFrame {
    
    return ^(CGFloat x, CGFloat y, CGFloat width, CGFloat height) {
        self.frame = CGRectMake(x, y, width, height);
        return self;
    };
}

/// 设置 size
- (UIButton *(^)(CGFloat width, CGFloat height))yxc_setSize {
    
    return ^(CGFloat width, CGFloat height) {
        self.size = CGSizeMake(width, height);
        return self;
    };
}

/// 设置 center
- (UIButton *(^)(CGFloat centerX, CGFloat centerY))yxc_setCenter {
    
    return ^(CGFloat centerX, CGFloat centerY) {
        self.center = CGPointMake(centerX, centerY);
        return self;
    };
}

/// 通过 CGPoint 设置 center
- (UIButton *(^)(CGPoint center))yxc_setCenterByPoint {
    
    return ^(CGPoint center) {
        self.center = center;
        return self;
    };
}

@end
