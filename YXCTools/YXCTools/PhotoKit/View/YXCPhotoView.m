//
//  YXCPhotoView.m
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoView.h"
#import "YXCPhotoHandler.h"

@interface YXCPhotoView ()

@end

@implementation YXCPhotoView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)getPhotos {
    
    // 先查看相册是否授权
    
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    UIImageView *imageView = [UIImageView new];
    imageView.image = [UIImage imageNamed:@"calendar"];
    imageView.size = CGSizeMake(200, 200);
    imageView.center = self.center;
    [self addSubview:imageView];
    
    CALayer *maskLayer = [[CALayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, 180, 90);
    maskLayer.contents = (__bridge id)[UIImage imageNamed:@"green_pop"].CGImage;
    imageView.layer.mask = maskLayer;
    
    //    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 150, 80)];
    //    imgView.image = [UIImage imageNamed:@"green_pop"];
    //    [imageView addSubview:imgView];
    //    imageView.layer.mask = imgView.layer;
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
