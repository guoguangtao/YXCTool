//
//  YXCiOS16Controller.m
//  YXCTools
//
//  Created by guogt on 2022/9/8.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCiOS16Controller.h"

@interface YXCiOS16Controller ()

@end

@implementation YXCiOS16Controller

/// 刷新UI
- (void)injected {

    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }

    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {

    NSLog(@"%s", __func__);
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


#pragma mark - Lazy


@end
