//
//  UIImage+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIImage+YXC_Category.h"

@implementation UIImage (YXC_Category)

/// 根据颜色创建一个 UIImage
/// @param color 颜色
+ (UIImage *)imageWithColor:(UIColor *)color {
    
    //图片尺寸
    CGRect rect = CGRectMake(0, 0, 10, 10);
    //填充画笔
    UIGraphicsBeginImageContext(rect.size);
    //根据所传颜色绘制
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    //显示区域
    CGContextFillRect(context, rect);
    // 得到图片信息
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    //消除画笔
    UIGraphicsEndImageContext();
    
    return image;
}

/// 图片压缩
/// @param maxLengthKB 压缩到的大小
/// @param complete 回调
- (void)compressWithMaxLengthKB:(NSUInteger)maxLengthKB
                       complete:(void (^)(NSData *imageData))complete {
    
    if (maxLengthKB <= 0 || [self isKindOfClass:[NSNull class]] || self == nil) complete(nil);
    
    maxLengthKB = maxLengthKB * 1024;
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        CGFloat compression = 1;
        NSData *data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(data);
            });
            return;
        }
        
        //质量压缩
        CGFloat scale = 1;
        CGFloat lastLength = 0;
        for (int i = 0; i < 7; ++i) {
            compression = scale / 2;
            data = UIImageJPEGRepresentation(self, compression);
            if (i > 0) {
                if (data.length > 0.95 * lastLength) break;//当前压缩后大小和上一次进行对比，如果大小变化不大就退出循环
                if (data.length < maxLengthKB) break;//当前压缩后大小和目标大小进行对比，小于则退出循环
            }
            scale = compression;
            lastLength = data.length;
            
        }
        if (data.length < maxLengthKB){
            dispatch_async(dispatch_get_main_queue(), ^{
                complete(data);
            });
            return;
        }
        
        // 图片尺寸压缩
        UIImage *resultImage = [UIImage imageWithData:data];
        NSUInteger lastDataLength = 0;
        while (data.length > maxLengthKB && data.length != lastDataLength) {
            lastDataLength = data.length;
            CGFloat ratio = (CGFloat)maxLengthKB / data.length;
            CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                     (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
            UIGraphicsBeginImageContext(size);
            [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
            resultImage = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
            data = UIImageJPEGRepresentation(resultImage, compression);
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            complete(data);
        });
        return;
    });
}

- (UIImage *)compressWithSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return resultImage;
}

@end
