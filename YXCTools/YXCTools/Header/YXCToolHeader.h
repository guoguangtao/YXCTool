//
//  YXCToolHeader.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#ifndef YXCToolHeader_h
#define YXCToolHeader_h

#pragma mark - 宏定义

#ifdef DEBUG
# define YXCLog(fmt, ...) NSLog((@"%s " "%d行 : " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define YXCLog(...);
#endif


/// 16进制 RGB 转 UIColor
#define kColorFromHexCode(hexcode) [UIColor colorWithRed:((float)((hexcode & 0xFF0000) >> 16)) / 255.0 \
green:((float)((hexcode & 0xFF00) >> 8)) / 255.0 \
blue:((float)(hexcode & 0xFF)) / 255.0 \
alpha:1.0];

/// 随机色
#define kRandom_color [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0f]
/// 整型自定义颜色
#define kICustom_color(r, g, b, a) [UIColor colorWithRed:(r) % 256 / 255.0 green:(g) % 256 / 255.0 blue:(b) % 256 / 255.0 alpha:(a)]
/// 浮点型自定义颜色
#define kFCustom_color(r, g, b, a) [UIColor colorWithRed:(r) green:(g) blue:(b) alpha:(a)]

/// weakSelf
#define YXCWeakSelf(type)  __weak typeof(type) weak##type = type;

/// 动态获取设备高度
#define IPHONE_HEIGHT [UIScreen mainScreen].bounds.size.height
/// 动态获取设备宽度
#define IPHONE_WIDTH [UIScreen mainScreen].bounds.size.width


#pragma mark - Header


#pragma mark - NSObject

#import "NSArray+Category.h"
#import "NSDictionary+Category.h"
#import "NSArray+Crash.h"
#import "NSDictionary+Crash.h"

#pragma mark - UIKit

#import "UIView+Category.h"
#import "UIControl+Category.h"
#import "UITextField+Category.h"
#import "UITextView+Category.h"


#endif /* YXCToolHeader_h */
