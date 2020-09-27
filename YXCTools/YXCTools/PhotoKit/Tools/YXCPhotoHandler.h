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

/// 相册/相机 访问工具类
@interface YXCPhotoHandler : NSObject

#pragma mark - Property


#pragma mark - Method

/// 相机权限
/// @param handler 第一次申请权限回调
+ (BOOL)cameraAuthorizationStatusCompletionHandler:(void (^)(BOOL granted))handler;


/// 相册权限
/// @param handler 第一次申请权限回调
+ (BOOL)photoAuthorizationStatus:(void(^)(PHAuthorizationStatus status))handler;

+ (void)getAllPhotoAlbums;


#pragma mark - 注释掉 AssetsLibrary 的方式

/// 获取所有相册分组
/// @param complete 完成回调
//+ (void)getAllPhotoAlbums:(void (^)(NSArray<NSDictionary *> *photos))complete;

/// 根据相册组获取相册中的图片
/// @param group 相册组
/// @param complete 完成回调
//+ (void)getPhotosWithGroup:(ALAssetsGroup *)group complete:(void (^)(NSArray<ALAsset *> *photos))complete;

@end
