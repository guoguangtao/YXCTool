//
//  UIDevice+YXC_Category.h
//  UIDeviceHandler
//
//  Created by GGT on 2020/7/2.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDeviceName.h"

NS_ASSUME_NONNULL_BEGIN

/// 点设置
#define kYXCPT(num) [UIDevice fitWithPt:(num)]

/// 像素设置
#define kYXCPX(num) [UIDevice fitWithPx:(num)]

@interface UIDevice (YXC_Category)

@property (nonatomic, assign, readonly, class, getter=isBangsScreen) BOOL bangsScreen;      /**< 是否是刘海屏 */
@property (nonatomic, assign, readonly, class) CGFloat statusBarHeight;                     /**< 状态栏高度 */
@property (nonatomic, assign, readonly, class) CGFloat navigationBarHeight;                 /**< 导航栏高度 */
@property (nonatomic, assign, readonly, class) CGFloat navigationAndStatusHeight;           /**< 导航栏和状态栏高度 */
@property (nonatomic, assign, readonly, class) CGFloat bottomBarHeight;                     /**< 底部栏高度 */
@property (nonatomic, assign, readonly, class) CGFloat tabbarHeight;                        /**< tabbar 高度 */
@property (nonatomic, assign, readonly, class) CGFloat navigationBarCenterY;                /**< 导航栏 CenterY */


/// 获取到机型
- (NSString *)platform;

/// 获取到机型名称
- (NSString *)platformName;

/// 根据像素设置实际值
/// @param px 设计稿具体值
+ (CGFloat)fitWithPx:(CGFloat)px;

/// 根据点设置实际值
/// @param pt 点具体值
+ (CGFloat)fitWithPt:(CGFloat)pt;

@end

NS_ASSUME_NONNULL_END
