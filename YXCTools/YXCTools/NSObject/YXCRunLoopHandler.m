//
//  YXCRunLoopHandler.m
//  YXCTools
//
//  Created by GGT on 2021/7/27.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCRunLoopHandler.h"

@interface YXCRunLoopHandler ()

@property (nonatomic, strong) dispatch_queue_t queue; /**< 队列 */
@property (nonatomic, assign) BOOL shouldKeepRunning; /**< 是否需要保持运行状态 */

@end

@implementation YXCRunLoopHandler

#pragma mark - Lifecycle

/// 创建一个运行循环
/// @param mode 运行循环模式
/// @param timeInterval 时间间隔
/// @param handler 需要处理的事件
+ (instancetype)handlerForMode:(NSRunLoopMode)mode
                  timeInterval:(CGFloat)timeInterval
                       handler:(dispatch_block_t)handler {
    
    return [[self alloc] initForMode:mode timeInterval:timeInterval handler:handler];
}

/// 创建一个运行循环
/// @param mode 运行循环模式
/// @param timeInterval 时间间隔
/// @param handler 需要处理的事件
- (instancetype)initForMode:(NSRunLoopMode)mode
               timeInterval:(CGFloat)timeInterval
                    handler:(dispatch_block_t)handler {
    
    if (self = [super init]) {
        
        // 创建一个串行队列
        _queue = dispatch_queue_create("yxc_runLoop_queue", DISPATCH_QUEUE_SERIAL);
        
        // 开启 runLoop
        __weak typeof(self) wkSelf = self;
        dispatch_async(self.queue, ^{
            NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
            //添中一个端口 让循环有任务可做
            [runLoop addPort:[NSPort port] forMode:mode];
            while (wkSelf.shouldKeepRunning) {
                [runLoop runMode:NSDefaultRunLoopMode
                      beforeDate:[NSDate dateWithTimeIntervalSinceNow:timeInterval]];
                if (handler) {
                    handler();
                }
            };
            CFRunLoopStop(CFRunLoopGetCurrent());
        });
    }
    
    return self;
}

- (void)dealloc {
    
    [self stop];
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

- (void)start {
    
    self.shouldKeepRunning = YES;
}

- (void)stop {
    
    self.shouldKeepRunning = NO;
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - 懒加载



@end
