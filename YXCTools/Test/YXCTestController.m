//
//  YXCTestController.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestController.h"

@interface YXCTestController ()<UITextFieldTextMaxLengthDelegate, UITextFieldDelegate>


@end

@implementation YXCTestController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
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
    
    UIButton *button = [UIButton new];
    button.yxc_colors = @[(__bridge id)UIColor.redColor.CGColor,
                          (__bridge id)UIColor.purpleColor.CGColor,
                          (__bridge id)UIColor.blueColor.CGColor];
    button.yxc_endPoint = CGPointMake(1, 0);
    button.yxc_locations = @[@0.3, @0.6];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];
    button.width = 300;
    button.height = 40;
    button.center = self.view.center;
}


#pragma mark - Constraints

- (void)setupConstraints {

    
}


#pragma mark - 懒加载

@end
