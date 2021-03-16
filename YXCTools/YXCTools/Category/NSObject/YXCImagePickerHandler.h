//
//  YXCImagePickerHandler.h
//  YXCTools
//
//  Created by GGT on 2020/8/28.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// image - 图片 info - 图片信息
typedef void(^YXCImagePickerComplete)(UIImage *image, NSDictionary *info);

@interface YXCImagePickerHandler : NSObject

#pragma mark - Property


#pragma mark - Method

/// 创建一个单例对象
+ (instancetype)shareImagePicker;

/// 选择相片或者拍照
/// @param owner 拥有者(利用 owner 跳转到 UIImagePickerController)
/// @param allowsEditing 是否允许编辑
/// @param complete 编辑或者选择照片/完成拍照回调
- (void)choosePhotoOrCameraWithController:(UIViewController *)owner
                            allowsEditing:(BOOL)allowsEditing
                                 complete:(YXCImagePickerComplete)complete;


/// 弹窗提示
/// @param title 提示标题
/// @param message 提示信息
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message;


@end
