//
//  YXCAssetModel.h
//  YXCTools
//
//  Created by GGT on 2020/10/9.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

@interface YXCAssetModel : NSObject

#pragma mark - Property

@property (nonatomic, assign) BOOL selected; /**< 是否被选中 */
@property (nonatomic, strong) PHAsset *asset; /**< 从相册中获取到的照片信息 */


#pragma mark - Method

+ (instancetype)modelWithAsset:(PHAsset *)asset;

@end
