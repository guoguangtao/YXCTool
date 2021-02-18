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

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.leftImageButton yxc_sizeToFit];
    [self.topImageButton yxc_sizeToFit];
    [self.bottomImageButton yxc_sizeToFit];
    [self.rightImageButton yxc_sizeToFit];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
    [self setupConstraints];
    
    [UIButton printfMethodWithSelector:@selector(layoutSubviews) isClassMethod:NO];
    [UIView printfMethodWithSelector:@selector(layoutSubviews) isClassMethod:NO];
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
    
    self.topImageButton = [self createdButtonWithTitle:@"上图下文" imagePosition:YXCButtomImageTop];
    
    self.leftImageButton = [self createdButtonWithTitle:@"左图下文" imagePosition:YXCButtomImageLeft];
    
    self.bottomImageButton = [self createdButtonWithTitle:@"底图上文" imagePosition:YXCButtomImageBottom];
    
    self.rightImageButton = [self createdButtonWithTitle:@"右图左文" imagePosition:YXCButtomImageRight];
}

- (UIButton *)createdButtonWithTitle:(NSString *)title imagePosition:(YXCButtomImage)imagePosition {
    
    UIButton *button = [UIButton new];
    button.backgroundColor = UIColor.orangeColor;
    button.yxc_imagePosition = imagePosition;
    button.yxc_imageTitleSpace = 10;
    [button setTitleColor:UIColor.redColor forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button yxc_setImage:@"emitter_like" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    return button;
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.topImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(UIDevice.navigationAndStatusHeight + 20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.leftImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topImageButton.mas_bottom).offset(20);
        make.centerX.width.height.equalTo(self.topImageButton);
    }];
    
    [self.bottomImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftImageButton.mas_bottom).offset(20);
        make.centerX.width.height.equalTo(self.topImageButton);
    }];
    
    [self.rightImageButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomImageButton.mas_bottom).offset(20);
        make.centerX.width.height.equalTo(self.topImageButton);
    }];
}


#pragma mark - 懒加载

@end
