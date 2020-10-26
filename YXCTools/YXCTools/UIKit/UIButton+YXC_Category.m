//
//  UIButton+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIButton+YXC_Category.h"
#import "UIImage+YXC_Category.h"

@implementation UIButton (YXC_Category)

- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state {
    
    [self setBackgroundImage:[UIImage imageWithColor:color] forState:state];
}

@end
