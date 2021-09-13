//
//  YXCBannerCell.m
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBannerCell.h"

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


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.textLabel = [UILabel new];
    self.textLabel.textColor = UIColor.orangeColor;
    [self.contentView addSubview:self.textLabel];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.contentView);
    }];
}


#pragma mark - Lazy

@end
