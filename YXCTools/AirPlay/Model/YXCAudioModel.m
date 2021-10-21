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
                        musicImage:(NSString *)musicImage
                          duration:(NSInteger)duration {
    YXCAudioModel *model = [YXCAudioModel new];
    model.musicName = musicName;
    model.musicUrl = [NSURL URLWithString:musicUrl];
    model.musicImage = [NSURL URLWithString:musicImage];
    model.duration = duration;
    return model;
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

+ (NSArray *)musics {
    
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:[self modelWithmusicName:@"突然好想你" musicUrl:@"http://aod.cos.tx.xmcdn.com/group4/M08/8B/66/wKgDtFRMkRixu-eXAB9ci3JlQYI913.mp3" musicImage:@"http://imgopen.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png" duration:264]];
    
    return [NSArray arrayWithArray:array];
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
