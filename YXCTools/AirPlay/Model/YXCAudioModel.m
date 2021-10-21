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
    [array addObject:[self modelWithmusicName:@"三寸天堂" musicUrl:@"http://aod.cos.tx.xmcdn.com/group4/M06/87/D1/wKgDs1RMgE6RreGUAB5l2BFTs8I423.mp3" musicImage:@"http://imgopen.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png" duration:253]];
    [array addObject:[self modelWithmusicName:@"等你的季节" musicUrl:@"http://aod.cos.tx.xmcdn.com/group4/M07/8B/31/wKgDtFRMf7Ly-cHyABx0qwLn37U487.mp3" musicImage:@"http://imgopen.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png" duration:238]];
    [array addObject:[self modelWithmusicName:@"知足" musicUrl:@"http://aod.cos.tx.xmcdn.com/group4/M03/87/F5/wKgDs1RMjB7CIzmiACF88QQ9P0E094.mp3" musicImage:@"http://imgopen.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png" duration:448]];
    [array addObject:[self modelWithmusicName:@"夜空中最亮的星" musicUrl:@"http://aod.cos.tx.xmcdn.com/group4/M02/8B/BF/wKgDtFRMr1eS1vN0AB75nWx2K0E398.mp3" musicImage:@"http://imgopen.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png" duration:261]];
    [array addObject:[self modelWithmusicName:@"虹之间" musicUrl:@"http://aod.cos.tx.xmcdn.com/group4/M04/88/60/wKgDs1RMsK-QW3r3ABzDAXt0va4929.mp3" musicImage:@"http://imgopen.xmcdn.com/group16/M02/5D/54/wKgDbFcpubOAcFbpAAFgmIO_2l8844.jpg!op_type=5&upload_type=album&device_type=ios&name=mobile_large&magick=png" duration:241]];
    
    return [NSArray arrayWithArray:array];
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
