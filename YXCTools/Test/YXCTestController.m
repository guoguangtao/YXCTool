//
//  YXCTestController.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestController.h"

@interface YXCTestController ()

@property (nonatomic, strong) UIButton *leftImageButton;
@property (nonatomic, strong) UIButton *topImageButton;
@property (nonatomic, strong) UIButton *bottomImageButton;
@property (nonatomic, strong) UIButton *rightImageButton;

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
    
    self.leftImageButton = [UIButton new];
    self.leftImageButton.backgroundColor = UIColor.orangeColor;
    [self.leftImageButton setTitle:@"左图右文" forState:UIControlStateNormal];
    [self.leftImageButton yxc_setImage:@"emitter_like" forState:UIControlStateNormal];
    [self.view addSubview:self.leftImageButton];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.leftImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(UIDevice.navigationAndStatusHeight + 20);
        make.centerX.equalTo(self.view);
    }];
}


#pragma mark - 懒加载

@end
