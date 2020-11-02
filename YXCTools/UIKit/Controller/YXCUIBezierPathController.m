//
//  YXCUIBezierPathController.m
//  YXCTools
//
//  Created by GGT on 2020/11/2.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCUIBezierPathController.h"
#import "YXCBezierPathView.h"

@interface YXCUIBezierPathController ()



@end

@implementation YXCUIBezierPathController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    YXCBezierPathView *blackView = [YXCBezierPathView new];
    blackView.width = 100;
    blackView.height = 100;
    blackView.center = self.view.center;
    blackView.backgroundColor = UIColor.blackColor;
    [self.view addSubview:blackView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
