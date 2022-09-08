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

#define kCellIdentifier @"DefalutCellIdentifier"

#define kYXCDateString ({\
NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init]; \
[dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss.SSS"]; \
NSString *dateString = [dateFormatter stringFromDate:[NSDate date]]; \
dateString; \
})

#define kYXCClass [NSString stringWithFormat:@"%s", __FILE__].lastPathComponent

#ifdef DEBUG
#define NSLog(fmt, ...) NSLog((@"<%@>%s " "%d行 : " fmt), ([NSThread currentThread].isMainThread ? @"主" : @"非主"), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define YXCPrintf(...) printf("%s : %s %s %d行 : %s\n", [kYXCDateString UTF8String], [kYXCClass UTF8String], __FUNCTION__, __LINE__, [[NSString stringWithFormat:__VA_ARGS__] UTF8String]);
#define YXCDebugLogMethod() NSLog(@"%s", __func__);
#else
#define NSLog(fmt, ...) NSLog((@"<%@>%s " "%d行 : " fmt), ([NSThread currentThread].isMainThread ? @"主" : @"非主"), __FUNCTION__, __LINE__, ##__VA_ARGS__);
#define YXCPrintf(...);
#define YXCDebugLogMethod();
#endif


/// 16进制 RGB 转 UIColor
#define kColorFromHexCode(hexcode) [UIColor colorWithRed:((float)((hexcode & 0xFF0000) >> 16)) / 255.0 \
green:((float)((hexcode & 0xFF00) >> 8)) / 255.0 \
blue:((float)(hexcode & 0xFF)) / 255.0 \
alpha:1.0]

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

/// 取消调用未知 selector 警告
#define YXCCancelPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)


/// 屏幕底部距离
#define kBottomBarHeight (kIsBangsScreen ? 34 : 0)
/// 导航栏高度不包括状态栏
#define kNavigationBarHeight 44
/// 导航栏高度包括状态栏
#define kTopBarHeight (kIsBangsScreen ? 88 : 64)
/// 状态栏高度
#define kStatusBarHeight (kIsBangsScreen ? 44 : 20)
/// 底部 tabbar 高度
#define kTabbarHeight (kIsBangsScreen ? 83 : 49)


#pragma mark - NSObject

#import "NSArray+YXC_Category.h"
#import "NSMutableArray+YXC_Category.h"
#import "NSDictionary+YXC_Category.h"
#import "NSMutableDictionary+YXC_Category.h"
#import "YXCImagePickerHandler.h"
#import "NSDate+YXC_Category.h"
#import "NSObject+YXC_Category.h"
#import "NSMutableAttributedString+YXC_Category.h"
#import "NSObject+YXCObserver.h"

#pragma mark - UIKit

#import "UIView+YXC_Category.h"
#import "UIControl+YXC_Category.h"
#import "UITextField+YXC_Category.h"
#import "UITextView+YXC_Category.h"
#import "UIDevice+YXC_Category.h"
#import "UIFont+YXC_Category.h"
#import "UIButton+YXC_Category.h"
#import "UIImage+YXC_Category.h"
#import "UIImageView+YXC_Category.h"
#import "UIColor+YXC_Category.h"

#endif /* YXCToolHeader_h */
