//
//  YXCRunLoopHandler.h
//  YXCTools
//
//  Created by GGT on 2021/7/27.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXCRunLoopHandler : NSObject

#pragma mark - Property


#pragma mark - Method

/// 创建一个运行循环
/// @param mode 运行循环模式
/// @param timeInterval 时间间隔
/// @param handler 需要处理的事件
+ (instancetype)handlerForMode:(NSRunLoopMode)mode
                  timeInterval:(CGFloat)timeInterval
                       handler:(dispatch_block_t)handler;

/// 创建一个运行循环
/// @param mode 运行循环模式
/// @param timeInterval 时间间隔
/// @param handler 需要处理的事件
- (instancetype)initForMode:(NSRunLoopMode)mode
               timeInterval:(CGFloat)timeInterval
                    handler:(dispatch_block_t)handler;

/// 运行循环开始工作
- (void)start;

/// 运行循环停止工作
- (void)stop;


@end
