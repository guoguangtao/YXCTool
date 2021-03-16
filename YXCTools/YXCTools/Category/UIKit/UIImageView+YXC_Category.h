//
//  UIImageView+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImageView (YXC_Category)

/// 设置图片
/// @param imageName 图片名称
- (void)yxc_setImageWithName:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
