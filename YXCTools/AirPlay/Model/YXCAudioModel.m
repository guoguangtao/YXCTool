//
//  YXCAudioModel.m
//  YXCTools
//
//  Created by lbkj on 2021/10/20.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCAudioModel.h"

@implementation YXCAudioModel


#pragma mark - Lifecycle

+ (instancetype)modelWithmusicName:(NSString *)musicName
                          musicUrl:(NSString *)musicUrl
                        musicImage:(NSString *)musicImage {
    YXCAudioModel *model = [YXCAudioModel new];
    model.musicName = musicName;
    model.musicUrl = [NSURL URLWithString:musicUrl];
    model.musicImage = [NSURL URLWithString:musicImage];
    return model;
}

- (void)setMusicUrl:(NSURL *)musicUrl {
    if ([musicUrl isKindOfClass:[NSString class]]) {
        _musicUrl = [NSURL URLWithString:(NSString *)musicUrl];
        return;
    }
    _musicUrl = musicUrl;
}

- (void)setMusicImage:(NSURL *)musicImage {
    if ([musicImage isKindOfClass:[NSString class]]) {
        _musicImage = [NSURL URLWithString:(NSString *)musicImage];
        return;
    }
    _musicImage = musicImage;
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
