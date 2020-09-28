//
//  YXCPhotoListImageCell.m
//  YXCTools
//
//  Created by GGT on 2020/9/25.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoListImageCell.h"

@interface YXCPhotoListImageCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YXCPhotoListImageCell

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)

- (void)setImage:(UIImage *)image {
    
    _image = image;
    
    self.imageView.image = image;
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    [self.contentView addSubview:self.imageView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
