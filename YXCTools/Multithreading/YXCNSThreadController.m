//
//  YXCNSThreadController.m
//  YXCTools
//
//  Created by GGT on 2020/11/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCNSThreadController.h"
#import "YXCThread.h"

@interface YXCNSThreadController ()

@property (nonatomic, strong) YXCThread *thread;

@end

@implementation YXCNSThreadController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    [YXCThread detachNewThreadSelector:@selector(test) toTarget:self withObject:@"name"];
    
    
//    YXCThread *thread = [[YXCThread alloc] initWithTarget:self selector:@selector(test) object:nil];
//    [thread start];
    
    
    YXCThread *thread = [[YXCThread alloc] initWithBlock:^{
        NSThread *currentThread = [YXCThread currentThread];
        YXCLog(@"%s, %@主线程", __func__, [NSThread isMainThread] ? @"是" : @"不是");
        YXCLog(@"%@", currentThread);
        YXCLog(@"%@多线程", [NSThread isMultiThreaded] ? @"是" : @"不是");
    }];
    thread.name = @"测试线程";
    [thread start];
    
//    [YXCThread detachNewThreadWithBlock:^{
//        NSThread *currentThread = [YXCThread currentThread];
//        YXCLog(@"%s, %@主线程", __func__, [NSThread isMainThread] ? @"是" : @"不是");
//        YXCLog(@"%@", currentThread);
//        YXCLog(@"%@多线程", [NSThread isMultiThreaded] ? @"是" : @"不是");
//        [YXCThread exit];
//    }];
    
    // 当前线程执行
//    [self performSelector:@selector(test) withObject:nil afterDelay:0];
}

- (void)test {
    
    NSThread *currentThread = [YXCThread currentThread];
    YXCLog(@"%s, %@主线程", __func__, [NSThread isMainThread] ? @"是" : @"不是");
    YXCLog(@"%@", currentThread);
    YXCLog(@"%@多线程", [NSThread isMultiThreaded] ? @"是" : @"不是");
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
