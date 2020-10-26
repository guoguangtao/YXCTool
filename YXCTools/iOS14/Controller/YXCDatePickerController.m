//
//  YXCDatePickerController.m
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCDatePickerController.h"
#import "YXCDatePickerView.h"

@interface YXCDatePickerController ()


@end

@implementation YXCDatePickerController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
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
    
    YXCDatePickerView *datePickerView = [[YXCDatePickerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:datePickerView];
    
    UIButton *button = [UIButton new];
    [button setBackgroundColor:UIColor.orangeColor forState:UIControlStateNormal];
    [button setBackgroundColor:UIColor.redColor forState:UIControlStateHighlighted];
    [button setBackgroundColor:UIColor.purpleColor forState:UIControlStateSelected];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(40);
    }];
}


- (void)buttonClicked:(UIButton *)button {
    
    button.selected = !button.isSelected;
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
