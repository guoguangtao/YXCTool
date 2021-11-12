//
//  YXCBlueToothManager.h
//  YXCTools
//
//  Created by lbkj on 2021/11/12.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCBlueToothManager : NSObject

#pragma mark - Property


#pragma mark - Method

+ (instancetype)shareInstance;

/// 开始搜索蓝牙设备
- (void)startScan;

@end

NS_ASSUME_NONNULL_END
