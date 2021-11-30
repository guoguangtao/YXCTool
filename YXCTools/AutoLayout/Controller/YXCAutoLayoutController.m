//
//  YXCAutoLayoutController.m
//  YXCTools
//
//  Created by lbkj on 2021/11/30.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCAutoLayoutController.h"

@interface YXCAutoLayoutController ()

@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *scanButton;

@end

@implementation YXCAutoLayoutController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {

}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.icon = [self createdButtonWithTitle:@"icon"];
    self.nameLabel = [self createdLabelWithText:@"WiFiName"];
    self.titleLabel = [self createdLabelWithText:@"这是标题"];
    self.scanButton = [self createdButtonWithTitle:@"ScanButton"];
}

- (UILabel *)createdLabelWithText:(NSString *)text {
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = UIColor.blackColor;
    label.text = text;
    label.backgroundColor = kRandom_color;
    [self.view addSubview:label];
    return label;
}

- (UIButton *)createdButtonWithTitle:(NSString *)title {
    
    UIButton *button = [UIButton new];
    button.backgroundColor = kRandom_color;
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    return button;
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    NSArray *arrayView = @[self.icon, self.nameLabel, self.titleLabel, self.scanButton];
    [arrayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.width.height.mas_equalTo(20);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(4);
        make.right.lessThanOrEqualTo(self.titleLabel.mas_left).offset(-13.5);
    }];
    
    [self.scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.width.height.mas_equalTo(44);
    }];
}


#pragma mark - Lazy


@end
