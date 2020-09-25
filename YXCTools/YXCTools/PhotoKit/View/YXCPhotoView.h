//
//  YXCPhotoView.h
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 相册访问
@interface YXCPhotoView : UIView

#pragma mark - Property


#pragma mark - Method

+ (instancetype)photoViewWithOwner:(UIViewController *)owner;

- (instancetype)initWithOwner:(UIViewController *)owner;

@end
