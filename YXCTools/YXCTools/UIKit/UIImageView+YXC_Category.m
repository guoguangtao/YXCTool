//
//  UIImageView+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "UIImageView+YXC_Category.h"

@implementation UIImageView (YXC_Category)

/// 设置图片
/// @param imageName 图片名称
- (void)yxc_setImageWithName:(NSString *)imageName {
    
    UIImage *image = [UIImage imageNamed:imageName];
    self.image = image;
}

@end
