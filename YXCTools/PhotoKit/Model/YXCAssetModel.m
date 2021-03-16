//
//  YXCAssetModel.m
//  YXCTools
//
//  Created by GGT on 2020/10/9.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCAssetModel.h"

@interface YXCAssetModel ()



@end

@implementation YXCAssetModel

#pragma mark - Lifecycle

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

+ (instancetype)modelWithAsset:(PHAsset *)asset {
    
    YXCAssetModel *model = [[YXCAssetModel alloc] init];
    model.asset = asset;
    
    return model;
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
