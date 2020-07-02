//
//  UIDevice+Handler.h
//  UIDeviceHandler
//
//  Created by GGT on 2020/7/2.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIDeviceName.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (Handler)

/// 获取到机型
- (NSString *)platform;

/// 获取到机型名称
- (NSString *)platformName;

@end

NS_ASSUME_NONNULL_END
