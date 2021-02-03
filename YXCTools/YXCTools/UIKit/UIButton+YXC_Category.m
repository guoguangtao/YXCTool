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
                          currentSelector:@selector(yxc_button_layoutSubviews)];
}

- (void)yxc_button_layoutSubviews {
    [self yxc_button_layoutSubviews];
    
    YXCLog(@"");
    
        CGSize imageViewSize = [self.imageView sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat imageViewWidth = imageViewSize.width;
        CGFloat imageViewHeigth = imageViewSize.height;
        CGFloat titleLabelWidth = titleLabelSize.width;
        CGFloat titleLabelHeight = titleLabelSize.height;
        CGFloat width = MAX(imageViewWidth, titleLabelWidth);
        CGFloat height = imageViewHeigth + titleLabelHeight;
        CGFloat x = 0;
        CGFloat y = 0;
//        self.size = CGSizeMake(width, height);
        x = (width - imageViewWidth) * 0.5f;
        y = (height - imageViewHeigth - titleLabelHeight) * 0.5f;
        self.imageView.frame = CGRectMake(x, y, imageViewWidth, imageViewHeigth);
        x = (width - titleLabelWidth) * 0.5f;
        y += imageViewHeigth;
        self.titleLabel.frame = CGRectMake(x, y, titleLabelWidth, titleLabelHeight);
    [self layoutIfNeeded];
}

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:state];
}

- (void)updateImagePosition:(YXCButtonImagePosition)imagePosition {
    
    if (imagePosition == YXCButtonImagePositionTop) {
        CGSize imageViewSize = [self.imageView sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGSize titleLabelSize = [self.titleLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
        CGFloat imageViewWidth = imageViewSize.width;
        CGFloat imageViewHeigth = imageViewSize.height;
        CGFloat titleLabelWidth = titleLabelSize.width;
        CGFloat titleLabelHeight = titleLabelSize.height;
        CGFloat width = MAX(imageViewWidth, titleLabelWidth);
        CGFloat height = imageViewHeigth + titleLabelHeight;
        CGFloat x = 0;
        CGFloat y = 0;
        self.size = CGSizeMake(width, height);
        x = (width - imageViewWidth) * 0.5f;
        y = (height - imageViewHeigth - titleLabelHeight) * 0.5f;
        self.imageView.frame = CGRectMake(x, y, imageViewWidth, imageViewHeigth);
        x = (width - titleLabelWidth) * 0.5f;
        y += imageViewHeigth;
        self.titleLabel.frame = CGRectMake(x, y, titleLabelWidth, titleLabelHeight);
    }
}

@end
