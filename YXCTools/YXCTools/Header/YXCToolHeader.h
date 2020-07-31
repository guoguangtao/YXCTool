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

#define kYXCDateString ({\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; \
[dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"]; \
NSString *dateString = [dateFormatter stringFromDate:[NSDate date]]; \
dateString; \
})

#define kYXCClass [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent

#ifdef DEBUG
#define YXCLog(fmt, ...) NSLog((@"%s " "%d行 : " fmt), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define YXCPrintf(...) printf("%s : %s %s %d行 : %s\n", [kYXCDateString UTF8String], [kYXCClass UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#else
#define YXCLog(...);
#define YXCPrintf(...);
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

/// 判断当前设备是否为刘海屏幕
#define kIsBangsScreen ({\
BOOL isBangsScreen = NO; \
if (@available(iOS 11.0, *)) { \
UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
if (window && [window isKindOfClass:[UIWindow class]]) { \
isBangsScreen = window.safeAreaInsets.bottom > 0; \
} \
}\
isBangsScreen; \
})


#pragma mark - Header

#import "Masonry.h"


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
#import "UIDevice+Handler.h"
#import "UIFont+Extension.h"
#import "YXCButton.h"

#endif /* YXCToolHeader_h */
