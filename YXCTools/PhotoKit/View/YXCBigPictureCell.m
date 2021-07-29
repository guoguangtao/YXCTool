//
//  YXCBigPictureCell.m
//  YXCTools
//
//  Created by GGT on 2021/7/29.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBigPictureCell.h"
#import "YXCAssetModel.h"

NSString *const YXCBigPictureCellIdentifier = @"YXCBigPictureCellIdentifier";

@interface YXCBigPictureCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YXCBigPictureCell

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
    
    
}


#pragma mark - Custom Accessors (Setter 方法)

- (void)setAssetModel:(YXCAssetModel *)assetModel {
    
    _assetModel = assetModel;
    
    YXCWeakSelf(self)
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    [[PHImageManager defaultManager] requestImageForAsset:assetModel.asset
                                               targetSize:self.imageView.bounds.size
                                              contentMode:PHImageContentModeDefault
                                                  options:option
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakself.imageView.image = result;
    }];
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.imageView = [UIImageView new];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imageView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark - 懒加载

@end
