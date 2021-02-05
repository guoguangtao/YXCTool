//
//  UIButton+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIButton+YXC_Category.h"
#import "UIImage+YXC_Category.h"
#import <objc/runtime.h>

@implementation UIButton (YXC_Category)

+ (void)load {
    
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(layoutSubviews)
                          currentSelector:@selector(yxc_layoutSubviews)];
}

- (void)yxc_layoutSubviews {
    [self yxc_layoutSubviews];
    
    self.imageView.backgroundColor = UIColor.purpleColor;
    self.titleLabel.backgroundColor = UIColor.greenColor;
    self.backgroundColor = UIColor.orangeColor;
    
    switch (self.yxc_imagePosition) {
        case YXCButtomImageLeft: [self setupImageLeft]; break;
        case YXCButtomImageBottom: [self setupImageBottom]; break;
        case YXCButtomImageRight: [self setupImageRight]; break;
        case YXCButtomImageTop: [self setupImageTop]; break;
    }
}

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
}

- (void)setupImageLeft {
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGFloat width = self.imageView.width + self.yxc_imageTitleSpace + self.titleLabel.width;
    
    self.imageView.x = (self.width - width) * 0.5f;
    [self.imageView sizeToFit];
    
    self.titleLabel.x = self.imageView.right + self.yxc_imageTitleSpace;
    [self.titleLabel sizeToFit];
}

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
}

- (void)setupImageRight {
    
    [self.titleLabel sizeToFit];
    [self.imageView sizeToFit];
    
    CGFloat width = self.imageView.width + self.yxc_imageTitleSpace + self.titleLabel.width;
    
    self.titleLabel.x = (self.width - width) * 0.5f;
    [self.titleLabel sizeToFit];
    
    self.imageView.x = self.titleLabel.right + self.yxc_imageTitleSpace;
    [self.imageView sizeToFit];
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
    
    [self setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
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

@end
