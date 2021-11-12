//
//  YXCPhotoListImageCell.m
//  YXCTools
//
//  Created by GGT on 2020/9/25.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoListImageCell.h"
#import "YXCAssetModel.h"
#import <Photos/Photos.h>

@interface YXCPhotoListImageCell ()

@property (nonatomic, strong) UIImageView *imageView; /**< 图片 */
@property (nonatomic, strong) UIButton *selectedButton; /**< 选中标志 */

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




#pragma mark - Custom Accessors (Setter 方法)

- (void)setAssetModel:(YXCAssetModel *)assetModel {
    
    _assetModel = assetModel;
    
    PHAsset *asset = assetModel.asset;
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    option.resizeMode = PHImageRequestOptionsResizeModeFast;
    YXCWeakSelf(self);
    [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:self.bounds.size contentMode:PHImageContentModeAspectFill options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakself.imageView.image = result;
    }];
    
    [self setupSelectedBackgroundColor];
}

- (void)setSelectedTitle:(NSString *)selectedTitle {
    
    _selectedTitle = selectedTitle;
    
    if (selectedTitle.length) {
        [self.selectedButton setTitle:selectedTitle forState:UIControlStateNormal];
    } else {
        [self.selectedButton setTitle:@"" forState:UIControlStateNormal];
    }
}


#pragma mark - IBActions

- (void)selectedButtonClicked {
    
    self.assetModel.selected = !self.assetModel.selected;
    [self setupSelectedBackgroundColor];
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(listImageCell:didSelectedWithAssetModel:)]) {
        [self.delegate listImageCell:self didSelectedWithAssetModel:self.assetModel];
    }
}


#pragma mark - Public


#pragma mark - Private

- (void)setupSelectedBackgroundColor {
    
    if (self.assetModel.selected) {
        self.selectedButton.backgroundColor = kColorFromHexCode(0x22B01A);
    } else {
        self.selectedButton.backgroundColor = UIColor.clearColor;
    }
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.imageView.clipsToBounds = YES;
    [self.contentView addSubview:self.imageView];
    
    CGFloat buttonWH = 20;
    CGFloat gap = 5;
    CGRect selectedButtonFrame = CGRectMake(self.width - buttonWH - gap, gap, buttonWH, buttonWH);
    self.selectedButton = [[UIButton alloc] initWithFrame:selectedButtonFrame];
    self.selectedButton.layer.cornerRadius = buttonWH * 0.5f;
    self.selectedButton.layer.borderWidth = 1.0f;
    self.selectedButton.layer.borderColor = UIColor.whiteColor.CGColor;
    self.selectedButton.layer.masksToBounds = YES;
    self.selectedButton.titleLabel.font = [UIFont systemFontOfSize:12];
    self.selectedButton.yxc_expandSize = 10;
    [self.selectedButton addTarget:self
                            action:@selector(selectedButtonClicked)
                  forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selectedButton];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
