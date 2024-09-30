//
//  YXCPhotoHandler.h
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "YXCAssetModel.h"

/// 遍历相册回调
typedef void(^YXCAlbumsPhotoAssetBlock)(NSArray <YXCAssetModel *> *_Nullable photos);

/// 相册/相机 访问工具类
@interface YXCPhotoHandler : NSObject

#pragma mark - Property


#pragma mark - Method

/// 相机权限
/// @param handler 第一次申请权限回调
+ (BOOL)cameraAuthorizationStatusCompletionHandler:(void (^_Nullable)(BOOL granted))handler;


/// 相册权限
/// @param handler 第一次申请权限回调
+ (BOOL)photoAuthorizationStatus:(void (^_Nullable)(PHAuthorizationStatus status))handler;

/// 获取所有图片
/// @param complete 完成回调
+ (void)getAllPhotoAlbumsComplete:(void (^_Nullable)(NSArray<NSDictionary *> *_Nullable photosArray))complete;


+ (void)getAlbumsPhotoWithCollection:(PHAssetCollection *_Nonnull)collection complete:(YXCAlbumsPhotoAssetBlock _Nullable)complete;

+ (void)getVideoWithAsset:(PHAsset *_Nullable)asset complete:(void (^_Nullable)(AVAsset *_Nullable asset, NSDictionary *_Nullable info))completion;


#pragma mark - 注释掉 AssetsLibrary 的方式

/// 获取所有相册分组
/// @param complete 完成回调
//+ (void)getAllPhotoAlbums:(void (^)(NSArray<NSDictionary *> *photos))complete;

/// 根据相册组获取相册中的图片
/// @param group 相册组
/// @param complete 完成回调
//+ (void)getPhotosWithGroup:(ALAssetsGroup *)group complete:(void (^)(NSArray<ALAsset *> *photos))complete;

@end
