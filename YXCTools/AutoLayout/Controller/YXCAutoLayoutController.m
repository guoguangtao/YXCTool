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
@property (nonatomic, strong) UILabel *redTextLabel;

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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];

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
    [self.nameLabel setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    self.titleLabel = [self createdLabelWithText:@"这是标题"];
    self.scanButton = [self createdButtonWithTitle:@"ScanButton"];
    [self.scanButton setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];

    self.redTextLabel = [self createdLabelWithText:@"这是一个红色的文本"];
}

- (UILabel *)createdLabelWithText:(NSString *)text {
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:15.0f];
    label.textColor = UIColor.blackColor;
    label.text = text;
    label.backgroundColor = kRandom_color;
    label.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:label];
    return label;
}

- (UIButton *)createdButtonWithTitle:(NSString *)title {
    
    UIButton *button = [UIButton new];
    button.backgroundColor = kRandom_color;
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [button setTitle:title forState:UIControlStateNormal];
    [self.view addSubview:button];
    return button;
}


#pragma mark - Constraints

- (void)setupConstraints {

    [self.view addConstraints:@[
        // self.icon 相对于父视图约束
        [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20],
        [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeWidth multiplier:1.0 constant:50],
        [NSLayoutConstraint constraintWithItem:self.icon attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1.0 constant:50],

        // self.nameLabel
        [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeRight multiplier:1.0 constant:10],
        [NSLayoutConstraint constraintWithItem:self.nameLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],

        // self.titleLabel
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.nameLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:5],
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.icon attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],
        [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.scanButton attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-5],

        // self.scanButton
        [NSLayoutConstraint constraintWithItem:self.scanButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-20],
        [NSLayoutConstraint constraintWithItem:self.scanButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0],

        // self.redView
        [NSLayoutConstraint constraintWithItem:self.redTextLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:20],
        [NSLayoutConstraint constraintWithItem:self.redTextLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:0.8 constant:0],
//        [NSLayoutConstraint constraintWithItem:self.redTextLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:0],
//        [NSLayoutConstraint constraintWithItem:self.redTextLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.25 constant:0],
    ]];
}


#pragma mark - Lazy


@end
