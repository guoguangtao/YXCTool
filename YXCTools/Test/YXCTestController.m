//
//  YXCTestController.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestController.h"

@interface YXCTestController ()

@property (nonatomic, strong) UIButton *button;

@end

@implementation YXCTestController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    

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

- (void)buttonClicked {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"结果" message:@"按钮被点击了" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.button = [UIButton new]
    .yxc_setTitle(@"按钮", UIControlStateNormal)
    .yxc_setBackgroundColor(UIColor.orangeColor, UIControlStateNormal)
    .yxc_addForSuperView(self.view)
    .yxc_setEventInterval(3.0f)
    .yxc_addAction(self, @selector(buttonClicked), UIControlEventTouchUpInside);
}


#pragma mark - Constraints

- (void)setupConstraints {

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark - 懒加载

@end
