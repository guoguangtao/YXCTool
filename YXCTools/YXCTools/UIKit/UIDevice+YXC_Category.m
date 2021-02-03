//
//  UIDevice+YXC_Category.m
//  UIDeviceHandler
//
//  Created by GGT on 2020/7/2.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UIDevice+YXC_Category.h"
#import <sys/utsname.h>

#define kDesignWidth 750

@implementation UIDevice (YXC_Category)

+ (BOOL)isBangsScreen {
    if (@available(iOS 11.0, *)) {
        UIWindow *window = [self appdelegateWindow];
        if (window && [window isKindOfClass:[UIWindow class]]) {
            return window.safeAreaInsets.bottom > 0;
        }
    }
    
    return NO;
}

/// 状态栏高度
+ (CGFloat)statusBarHeight {

    if (@available(iOS 11.0, *)) {
        return [self appdelegateWindow].safeAreaInsets.top;
    }
    
    return 20;
}

/// 导航栏高度
+ (CGFloat)navigationBarHeight {

    return 44;
}

/// 导航栏+状态栏高度
+ (CGFloat)navigationAndStatusHeight {

    return [self statusBarHeight] + [self navigationBarHeight];
}

/// 导航栏 CenterY
+ (CGFloat)navigationBarCenterY {
    
    return [self statusBarHeight] + [self navigationBarHeight] * 0.5f;
}

/// 底部高度
+ (CGFloat)bottomBarHeight {

    if (@available(iOS 11.0, *)) {
        return [self appdelegateWindow].safeAreaInsets.bottom;
    }
    
    return 0;
}

///  tabbar 高度
+ (CGFloat)tabbarHeight {

    CGFloat height = 49;
    if (@available(iOS 11.0, *)) {
        height += [self appdelegateWindow].safeAreaInsets.bottom;
    }
    
    return height;
}

/// 获取 window
+ (UIWindow *)appdelegateWindow {
    
    return [[UIApplication sharedApplication].windows firstObject];
}

- (NSString *)platform {
    
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];

    return deviceString;
}

/// 获取到设备的型号
- (NSString *)platformName {
    
    NSString *platform = [self platform];
    return [self platformDictionary][platform];
}

/// 所有机型数据
- (NSDictionary *)platformDictionary {
    
    return @{
        @"iPhone1,1" : iPhone,
        @"iPhone1,2" : iPhone3G,
        @"iPhone2,1" : iPhone3GS,
        @"iPhone3,1" : iPhone4,
        @"iPhone3,2" : iPhone4,
        @"iPhone3,3" : iPhone4,
        @"iPhone4,1" : iPhone4S,
        @"iPhone5,1" : iPhone5,
        @"iPhone5,2" : iPhone5,
        @"iPhone5,3" : iPhone5c,
        @"iPhone5,4" : iPhone5c,
        @"iPhone6,1" : iPhone5s,
        @"iPhone6,2" : iPhone5s,
        @"iPhone7,2" : iPhone6,
        @"iPhone7,1" : iPhone6Plus,
        @"iPhone8,1" : iPhone6s,
        @"iPhone8,2" : iPhone6sPlus,
        @"iPhone8,4" : iPhoneSE1,
        @"iPhone9,1" : iPhone7,
        @"iPhone9,3" : iPhone7,
        @"iPhone9,2" : iPhone7Plus,
        @"iPhone9,4" : iPhone7Plus,
        @"iPhone10,1" : iPhone8,
        @"iPhone10,4" : iPhone8,
        @"iPhone10,2" : iPhone8Plus,
        @"iPhone10,5" : iPhone8Plus,
        @"iPhone10,3" : iPhoneX,
        @"iPhone10,6" : iPhoneX,
        @"iPhone11,8" : iPhoneXR,
        @"iPhone11,2" : iPhoneXS,
        @"iPhone11,6" : iPhoneXSMax,
        @"iPhone11,4" : iPhoneXSMax,
        @"iPhone12,1" : iPhone11,
        @"iPhone12,3" : iPhone11Pro,
        @"iPhone12,5" : iPhone11ProMax,
        @"iPhone12,8" : iPhoneSE2,
        @"x86_64" : simulator,
        @"i386" : simulator,
        @"iPad1,1" : iPad,
        @"iPad2,1" : iPad2,
        @"iPad2,2" : iPad2,
        @"iPad2,3" : iPad2,
        @"iPad2,4" : iPad2,
        @"iPad3,1" : iPad3,
        @"iPad3,2" : iPad3,
        @"iPad3,3" : iPad3,
        @"iPad3,4" : iPad4,
        @"iPad3,5" : iPad4,
        @"iPad3,6" : iPad4,
        @"iPad6,11" : iPad5,
        @"iPad6,12" : iPad5,
        @"iPad7,5" : iPad6,
        @"iPad7,6" : iPad6,
        @"iPad7,11" : iPad7,
        @"iPad7,12" : iPad7,
        @"iPad4,1" : iPadAir,
        @"iPad4,2" : iPadAir,
        @"iPad4,3" : iPadAir,
        @"iPad5,3" : iPadAir2,
        @"iPad5,4" : iPadAir2,
        @"iPad11,3" : iPadAir3,
        @"iPad11,4" : iPadAir3,
        @"iPad6,7" : iPadPro12_9_inch,
        @"iPad6,8" : iPadPro12_9_inch,
        @"iPad6,3" : iPadPro9_7_inch,
        @"iPad6,4" : iPadPro9_7_inch,
        @"iPad7,1" : iPadPro12_9_inch2,
        @"iPad7,2" : iPadPro12_9_inch2,
        @"iPad7,3" : iPadPro10_5_inch,
        @"iPad7,4" : iPadPro10_5_inch,
        @"iPad8,1" : iPadPro11_inch,
        @"iPad8,2" : iPadPro11_inch,
        @"iPad8,3" : iPadPro11_inch,
        @"iPad8,4" : iPadPro11_inch,
        @"iPad8,5" : iPadPro12_9_inch3,
        @"iPad8,6" : iPadPro12_9_inch3,
        @"iPad8,7" : iPadPro12_9_inch3,
        @"iPad8,8" : iPadPro12_9_inch3,
        @"iPad8,9" : iPadPro11_inch2,
        @"iPad8,10" : iPadPro11_inch2,
        @"iPad8,11" : iPadPro12_9_inch4,
        @"iPad8,12" : iPadPro12_9_inch4,
        @"iPad2,5" : iPadmini,
        @"iPad2,6" : iPadmini,
        @"iPad2,7" : iPadmini,
        @"iPad4,4" : iPadmini2,
        @"iPad4,5" : iPadmini2,
        @"iPad4,6" : iPadmini2,
        @"iPad4,7" : iPadmini3,
        @"iPad4,8" : iPadmini3,
        @"iPad4,9" : iPadmini3,
        @"iPad5,1" : iPadmini4,
        @"iPad5,2" : iPadmini4,
        @"iPad11,1" : iPadmini5,
        @"iPad11,2" : iPadmini5,
    };
}

/// 根据像素设置实际值
/// @param px 设计稿具体值
+ (CGFloat)fitWithPx:(CGFloat)px {
    
    return [UIScreen mainScreen].bounds.size.width / kDesignWidth * px;
}

/// 根据点设置实际值
/// @param pt 点具体值
+ (CGFloat)fitWithPt:(CGFloat)pt {
    
    return [UIScreen mainScreen].bounds.size.width / kDesignWidth * 2 * pt;
}

@end
