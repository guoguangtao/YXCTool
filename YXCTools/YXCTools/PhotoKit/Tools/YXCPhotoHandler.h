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

+ (void)getAllPhotoAlbums:(void (^)(NSArray<NSDictionary *> *photos))complete;

+ (void)getPhotosWithGroup:(ALAssetsGroup *)group complete:(void (^)(NSArray<ALAsset *> *photos))complete;

@end
