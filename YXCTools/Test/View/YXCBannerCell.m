//
//  YXCBannerCell.m
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBannerCell.h"

#define kContentViewMidWidth (IPHONE_WIDTH - 20) * 0.5f

@interface YXCBannerCell ()

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation YXCBannerCell

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kRandom_color;
        self.contentView.layer.cornerRadius = 10.0f;
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setText:(NSString *)text {
    
    self.textLabel.text = text;
}


#pragma mark - IBActions


#pragma mark - Public

- (void)yxc_animationWithScrollView:(UIScrollView *)scrollView layout:(nonnull UICollectionViewFlowLayout *)layout {
    
    // 坐标转换
    CGPoint point = [self.contentView convertPoint:self.contentView.origin toView:[UIApplication sharedApplication].windows.firstObject];
    CGFloat x = point.x;
    if (x >= IPHONE_WIDTH * 0.5f) {
        self.textLabel.x = kContentViewMidWidth;
    } else {
        if (x <= layout.sectionInset.left || self.textLabel.left < 20) {
            self.textLabel.x = 20;
            return;
        }
        
        self.textLabel.x = MAX(20, x - layout.sectionInset.left);
    }
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.textLabel = [UILabel new];
    self.textLabel.textColor = UIColor.whiteColor;
    [self.contentView addSubview:self.textLabel];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(20);
    }];
}


#pragma mark - Lazy

@end
