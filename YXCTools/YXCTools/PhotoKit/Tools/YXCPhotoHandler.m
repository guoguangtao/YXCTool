//
//  YXCPhotoHandler.m
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoHandler.h"
#import <objc/runtime.h>

@interface YXCPhotoHandler ()



#pragma mark - 注释掉 AssetsLibrary 的方式
//@property (nonatomic, strong, class) ALAssetsLibrary *assetsLibrary;

@end

@implementation YXCPhotoHandler

#pragma mark - Lifecycle

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

/// 相机权限
+ (BOOL)cameraAuthorizationStatusCompletionHandler:(void (^)(BOOL))handler {
    
    NSString *mediaType = AVMediaTypeVideo;//读取媒体类型
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];//读取设备授权状态
    
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined: YXCLog(@"还没申请权限,现在开始申请"); break;
        case AVAuthorizationStatusRestricted : YXCLog(@"相机受限制"); break;
        case AVAuthorizationStatusDenied : YXCLog(@"相机权限被拒绝"); break;
        case AVAuthorizationStatusAuthorized : YXCLog(@"相机权限已授权"); break;
    }
    
    if (authStatus == AVAuthorizationStatusNotDetermined) {
        // 还未申请权限,申请权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [AVCaptureDevice requestAccessForMediaType:mediaType completionHandler:^(BOOL granted) {
                if (handler) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(granted);
                    });
                }
            }];
        });
    } else if (authStatus != AVAuthorizationStatusAuthorized) {
        // 相机权限未授予
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (appName == nil) {
            appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        };
        NSString *title = [NSString stringWithFormat:@"请在“设置-隐私-相机”选项中允许<< %@ >>访问你的相机", appName];
        [self showAlertWithTitle:title message:nil];
    }
    
    return authStatus == AVAuthorizationStatusAuthorized;
}

/// 相册权限
+ (BOOL)photoAuthorizationStatus:(void (^)(PHAuthorizationStatus))handler {
    
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    switch (authStatus) {
        case PHAuthorizationStatusNotDetermined: YXCLog(@"相册还没申请权限,现在开始申请"); break;
        case PHAuthorizationStatusRestricted : YXCLog(@"相册受限制"); break;
        case PHAuthorizationStatusDenied : YXCLog(@"相册权限被拒绝"); break;
        case PHAuthorizationStatusAuthorized : YXCLog(@"相册权限已授权"); break;
        case PHAuthorizationStatusLimited: YXCLog(@"相册部分授权"); break;
    }
    
    if (authStatus == PHAuthorizationStatusNotDetermined) {
        // 还未申请权限,申请权限
        dispatch_async(dispatch_get_main_queue(), ^{
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (handler) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        handler(status);
                    });
                }
            }];
        });
    } else if (authStatus != PHAuthorizationStatusAuthorized) {
        // 相机权限未授予
        NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"];
        if (appName == nil) {
            appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleName"];
        };
        NSString *title = [NSString stringWithFormat:@"请在“设置-隐私-相册”选项中允许<< %@ >>访问你的相册", appName];
        [self showAlertWithTitle:title message:nil];
    }
    
    return authStatus == PHAuthorizationStatusAuthorized;
}

/// 弹窗提示
/// @param title 提示标题
/// @param message 提示信息
+ (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:sureAction];
    
    NSArray *windowsArray = [UIApplication sharedApplication].windows;
    
    for (UIWindow *windows in windowsArray) {
        if (windows.rootViewController) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [windows.rootViewController presentViewController:alertController animated:YES completion:nil];
            });
            return;
        }
    }
}

+ (void)getAllPhotoAlbumsComplete:(void (^)(NSArray<NSDictionary *> *))complete {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray<NSDictionary *> *assets = [NSMutableArray array];
        PHFetchResult *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum
                                                                              subtype:PHAssetCollectionSubtypeAlbumRegular
                                                                              options:nil];
        [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection *collection, NSUInteger idx, BOOL * _Nonnull stop) {
            if (collection) {
                // 先定义一个过滤器,按照创建时间降序
                PHFetchOptions *options = [PHFetchOptions new];
                NSSortDescriptor *createData = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];
                options.sortDescriptors = @[createData];
                
                PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:options];
                if (result.count) {
                    // 相册名称
                    NSString *albumsName = collection.localizedTitle;
                    [assets addObject:@{@"name" : albumsName, @"collection" : collection}];
                }
    //            [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
    //                if (asset.mediaType == PHAssetMediaTypeImage) {
    //                    [assets addObject:asset];
    //                }
    //            }];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete([NSArray arrayWithArray:assets]);
            }
        });
    });
}

+ (void)getAlbumsPhotoWithCollection:(PHAssetCollection *)collection complete:(void (^)(NSArray<UIImage *> *))complete {
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        YXCLog(@"遍历相册");
        NSMutableArray<UIImage *> *imagesArray = [NSMutableArray array];
        // 先定义一个过滤器,按照创建时间降序
        PHFetchOptions *options = [PHFetchOptions new];
        NSSortDescriptor *createData = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO];
        options.sortDescriptors = @[createData];
        
        PHFetchResult *result = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        [result enumerateObjectsUsingBlock:^(PHAsset *asset, NSUInteger idx, BOOL * _Nonnull stop) {
            YXCLog(@"遍历到图片");
            if (asset.mediaType == PHAssetMediaTypeImage) {
                PHImageManager *imageManager = [[PHImageManager alloc] init];
                PHImageRequestOptions *opt = [[PHImageRequestOptions alloc]init];
                opt.synchronous = YES;
                [imageManager requestImageDataForAsset:asset
                                               options:opt
                                         resultHandler:^(NSData * _Nullable imageData, NSString * _Nullable dataUTI, UIImageOrientation orientation, NSDictionary * _Nullable info) {
                    UIImage *image = [UIImage imageWithData:imageData];
                    [imagesArray addObject:image];
                    YXCLog(@"字典：%@", info);
                }];
            }
        }];
        
        YXCLog(@"遍历完成");
        dispatch_async(dispatch_get_main_queue(), ^{
            if (complete) {
                complete(imagesArray);
            }
        });
    });
}

#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载


#pragma mark - 注释掉 AssetsLibrary 的方式

/// 获取所有相册分组
/// @param complete 完成回调
//+ (void)getAllPhotoAlbums:(void (^)(NSArray<NSDictionary *> *))complete {
//    if (!YXCPhotoHandler.assetsLibrary) {
//        YXCPhotoHandler.assetsLibrary = [[ALAssetsLibrary alloc] init];
//    }
//
//    NSMutableArray<NSDictionary *> *albumsArray = [NSMutableArray array];
//
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        [YXCPhotoHandler.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
//            if (group) {
//                [group setAssetsFilter:[ALAssetsFilter allPhotos]];
//                if (group.numberOfAssets) {
//                    NSString *groupName = [group valueForProperty:ALAssetsGroupPropertyName];
//                    NSNumber *type = [group valueForProperty:ALAssetsGroupPropertyType];
//                    NSString *persistentID = [group valueForProperty:ALAssetsGroupPropertyPersistentID];
//                    NSURL *url = [group valueForProperty:ALAssetsGroupPropertyURL];
//
//                    NSDictionary *dict = @{
//                        @"name" : groupName,
//                        @"type" : type,
//                        @"persistentID" : persistentID,
//                        @"URL" : url,
//                        @"group" : group
//                    };
//                    [albumsArray addObject:dict];
//                }
//            } else {
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    if (complete) {
//                        complete([NSArray arrayWithArray:albumsArray]);
//                    }
//                });
//            }
//        } failureBlock:^(NSError *error) {
//            NSLog(@"Asset group failed");
//        }];
//    });
//
//}

/// 根据相册组获取相册中的图片
/// @param group 相册组
/// @param complete 完成回调
//+ (void)getPhotosWithGroup:(ALAssetsGroup *)group complete:(void (^)(NSArray<ALAsset *> *))complete {
//
//    NSMutableArray *imagesArray = [NSMutableArray array];
//    [group enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
//        if (result) {
//            YXCLog(@"图片所在的字节数：%ld", [result defaultRepresentation].size);
//            [imagesArray addObject:result];
//        } else {
//            dispatch_async(dispatch_get_main_queue(), ^{
//                if (complete) {
//                    complete(imagesArray);
//                }
//            });
//        }
//    }];
//}

//+ (void)setAssetsLibrary:(ALAssetsLibrary *)assetsLibrary {
//
//    objc_setAssociatedObject(self, @selector(assetsLibrary), assetsLibrary, OBJC_ASSOCIATION_RETAIN);
//}
//
//+ (ALAssetsLibrary *)assetsLibrary {
//
//    return objc_getAssociatedObject(self, @selector(assetsLibrary));
//}



@end
