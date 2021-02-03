//
//  UIImage+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef struct __UICornerInset {
    CGFloat topLeft;
    CGFloat topRight;
    CGFloat bottomLeft;
    CGFloat bottomRight;
} UICornerInset;

UIKIT_EXTERN const UICornerInset UICornerInsetZero;

UIKIT_STATIC_INLINE UICornerInset UICornerInsetMake(CGFloat topLeft, CGFloat topRight, CGFloat bottomLeft, CGFloat bottomRight)
{
    UICornerInset cornerInset = {topLeft, topRight, bottomLeft, bottomRight};
    return cornerInset;
}

UIKIT_STATIC_INLINE UICornerInset UICornerInsetMakeWithRadius(CGFloat radius) {
    UICornerInset cornerInset = {radius, radius, radius, radius};
    return cornerInset;
}

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



/// 根据颜色创建图片
/// @param color 颜色值
/// @param size 大小
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size;
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size cornerRadius:(CGFloat)cornerRadius;
+ (UIImage *)imageWithColor:(UIColor*)color size:(CGSize)size cornerInset:(UICornerInset)cornerInset;

/*
 * tint只对里面的图案作更改颜色操作
 */
- (UIImage *)yxc_imageWithTintColor:(UIColor *)tintColor;
- (UIImage *)yxc_imageWithTintColor:(UIColor *)tintColor blendMode:(CGBlendMode)blendMode;
- (UIImage *)yxc_imageWithGradientTintColor:(UIColor *)tintColor;


@end

NS_ASSUME_NONNULL_END
