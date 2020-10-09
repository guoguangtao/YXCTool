//
//  YXCBigPictureView.m
//  YXCTools
//
//  Created by GGT on 2020/10/9.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCBigPictureView.h"
#import "YXCAssetModel.h"

@interface YXCBigPictureView ()


@end

@implementation YXCBigPictureView

{
    UIImageView *_imageView;
}

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9f];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _imageView.frame = self.bounds;
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setModel:(YXCAssetModel *)model {
    
    _model = model;
    
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    YXCWeakSelf(_imageView)
    [[PHImageManager defaultManager] requestImageForAsset:model.asset targetSize:_imageView.bounds.size contentMode:PHImageContentModeDefault options:option resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weak_imageView.image = result;
    }];
}


#pragma mark - IBActions


#pragma mark - Public

+ (instancetype)showWithAssetModel:(YXCAssetModel *)model {
    
    YXCBigPictureView *bigPicView = [YXCBigPictureView new];
    bigPicView.model = model;
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    for (UIWindow *window in windows) {
        if (window) {
            bigPicView.frame = window.bounds;
            [window addSubview:bigPicView];
            break;
        }
    }
    
    return bigPicView;
}

- (void)dismiss {
    
    [self removeFromSuperview];
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    _imageView = [UIImageView new];
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:_imageView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
