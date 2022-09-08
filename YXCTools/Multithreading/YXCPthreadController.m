//
//  YXCPthreadController.m
//  YXCTools
//
//  Created by GGT on 2020/11/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPthreadController.h"
#import <pthread.h>

@interface YXCPthreadController ()



@end

@implementation YXCPthreadController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    pthread_t thread;
    pthread_create(&thread, NULL, test, NULL);
    pthread_detach(thread);
}

void *test(void *data) {
    
    NSLog(@"%s", __func__);
    
    return NULL;
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
