//
//  YXCButton.m
//  YXCTools
//
//  Created by GGT on 2020/7/30.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCButton.h"

@interface YXCButton ()

@end

@implementation YXCButton

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self layoutSubviews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.yxc_space = 5;
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleWidth = CGRectGetWidth(self.titleLabel.frame);
    CGFloat titleHeight = CGRectGetHeight(self.titleLabel.frame);
    CGFloat imageViewWidth = CGRectGetWidth(self.imageView.frame);
    CGFloat imageViewHeight = CGRectGetHeight(self.imageView.frame);
    switch (self.yxc_imagePosition) {
        case YXCButtonImagePositionTop: {
            CGFloat height = imageViewHeight + self.yxc_space + titleHeight;
            self.imageView.y = -(height - self.height) * 0.5f;
            self.imageView.centerX = self.width * 0.5f;
            self.titleLabel.y = self.imageView.bottom + self.yxc_space;
            self.titleLabel.centerX = self.imageView.centerX;
            
            self.yxc_horizontalSize = (MAX(titleWidth, imageViewWidth) - self.width) * 0.5f;
            self.yxc_verticalSize = (height - self.height) * 0.5f;
        } break;
        case YXCButtonImagePositionBottom: {
            CGFloat height = titleHeight + self.yxc_space + imageViewHeight;
            self.titleLabel.y = -(height - self.height) * 0.5f;
            self.titleLabel.centerX = self.width * 0.5f;
            self.imageView.y = self.titleLabel.bottom + self.yxc_space;
            self.imageView.centerX = self.titleLabel.centerX;
            self.yxc_horizontalSize = (MAX(titleWidth, imageViewWidth) - self.width) * 0.5f;
            self.yxc_verticalSize = (height - self.height) * 0.5f;
        } break;
        case YXCButtonImagePositionRight: {
            CGFloat width = titleWidth + self.yxc_space + imageViewWidth;
            self.titleLabel.x = -(width - self.width) * 0.5f;
            self.imageView.x = self.titleLabel.right + self.yxc_space;
            self.yxc_horizontalSize = (width - self.width) * 0.5f;
            self.yxc_verticalSize = (MAX(titleHeight, imageViewHeight) - self.height) * 0.5f;
        } break;
        case YXCButtonImagePositionLeft: {
            CGFloat width = imageViewWidth + self.yxc_space + titleWidth;
            self.imageView.x = -(width - self.width) * 0.5f;
            self.titleLabel.x = self.imageView.right + self.yxc_space;
            self.yxc_horizontalSize = (width - self.width) * 0.5f;
            self.yxc_verticalSize = (MAX(titleHeight, imageViewHeight) - self.height) * 0.5f;
        } break;
            
        default:
            break;
    }
    
    
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
