//
//  YXCMusicHandler.m
//  YXCTools
//
//  Created by lbkj on 2021/10/23.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCMusicHandler.h"

@implementation YXCMusicHandler


static YXCMusicHandler *_instance;

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    
    return _instance;
}

#pragma mark - Lifecycle

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy

- (NSArray<YXCAudioModel *> *)musics {
    if (_musics) {
        return _musics;
    }
    NSMutableArray<YXCAudioModel *> *array = [NSMutableArray array];
    NSURL *plistURL = [[NSBundle mainBundle] URLForResource:@"Musics" withExtension:@"plist"];
    NSArray *plistArray = [NSArray arrayWithContentsOfURL:plistURL];
    for (NSDictionary *dict in plistArray) {
        YXCAudioModel *model = [YXCAudioModel new];
        [model setValuesForKeysWithDictionary:dict];
        [array addObject:model];
    }
    _musics = [NSArray arrayWithArray:array];
    return _musics;
}


@end
