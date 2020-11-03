//
//  UIImage+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (YXC_Category)

/// 根据颜色创建一个 UIImage
/// @param color 颜色
+ (UIImage *)imageWithColor:(UIColor *)color;

/// 图片压缩
/// @param maxLengthKB 压缩到的大小
/// @param complete 回调
- (void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB
                       complete:(void (^)(NSData *imageData))complete;


- (UIImage *)compressWithSize:(CGSize)size;


@end

NS_ASSUME_NONNULL_END
