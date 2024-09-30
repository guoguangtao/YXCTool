//
//  YXCBigPictureCell.m
//  YXCTools
//
//  Created by GGT on 2021/7/29.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBigPictureCell.h"
#import "YXCAssetModel.h"
#import <AVKit/AVPlayerViewController.h>
#import "AppDelegate.h"
#import "YXCPhotoHandler.h"

NSString *const YXCBigPictureCellIdentifier = @"YXCBigPictureCellIdentifier";

@interface YXCBigPictureCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) AVPlayer *player;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayerLayer *playerLayer;

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
    
    NSLog(@"%@ - %@", self, assetModel);
    YXCWeakSelf(self)
    PHImageRequestOptions *option = [PHImageRequestOptions new];
    [[PHImageManager defaultManager] requestImageForAsset:assetModel.asset
                                               targetSize:self.imageView.bounds.size
                                              contentMode:PHImageContentModeDefault
                                                  options:option
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        weakself.imageView.image = result;
    }];
    
    [self getVideoWithAsset:assetModel.asset];
}

- (void)getVideoWithAsset:(PHAsset *)asset {
    
    [YXCPhotoHandler getVideoWithAsset:asset complete:^(AVAsset * _Nullable asset, NSDictionary * _Nullable info) {
        if ([asset isKindOfClass:[AVURLAsset class]]) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                NSString *videoUrl = [(AVURLAsset *)asset URL].absoluteString;
                [self p_playVideoWithURL:videoUrl];
            });
        }
    }];
}

- (void)playerVideoWithUrl:(NSString *)urlString {
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self p_playVideoWithURL:urlString];
    });
}


// 播放视频
- (void)p_playVideoWithURL:(NSString *)urlString {
    NSLog(@"视频播放地址 : %@", urlString);
    
    if (self.player) {
        [self.player pause];
        self.player = nil;
    }
    
    if (self.playerItem) {
        self.playerItem = nil;
    }
    
    if (self.playerLayer) {
        [self.playerLayer removeFromSuperlayer];
        self.playerLayer = nil;
    }
    
    // 初始化 AVPlayer 并播放视频
    self.playerItem = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:urlString]];
    self.player = [AVPlayer playerWithPlayerItem:self.playerItem];
    self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    
    // 设置 playerLayer 尺寸
    self.playerLayer.frame = self.bounds;
    self.playerLayer.videoGravity = AVLayerVideoGravityResizeAspect;
    
    // 将 playerLayer 添加到视图中
    [self.layer addSublayer:self.playerLayer];
    
    // 播放视频
    [self.player play];
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
