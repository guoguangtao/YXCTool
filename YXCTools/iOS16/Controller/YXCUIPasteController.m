//
//  YXCUIPasteController.m
//  YXCTools
//
//  Created by guogt on 2022/9/9.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCUIPasteController.h"

@interface YXCUIPasteController ()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIPasteControl *pastControl;

@end

@implementation YXCUIPasteController

/// 刷新UI
- (void)injected {

    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }

    self.pastControl = nil;
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

    NSLog(@"%@", self);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)buttonClicked {

    if (@available(iOS 16.0, *)) {
        [self.pastControl sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UIPasteConfigurationSupporting



#pragma mark - UI

- (void)setupUI {

    // textView
    self.textView = [UITextView new];
    self.textView.backgroundColor = UIColor.orangeColor;
    [self.view addSubview:self.textView];

    // button
    self.button = [UIButton new];
    self.button.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.button setTitle:@"粘贴" forState:UIControlStateNormal];
    [self.view addSubview:self.button];
}


#pragma mark - Constraints

- (void)setupConstraints {

    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(100);
        make.right.equalTo(self.view).offset(-100);
        make.centerY.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];

    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20 + kTopBarHeight);
        make.centerX.equalTo(self.view);
    }];
}


#pragma mark - Lazy

- (UIPasteControl *)pastControl {
    if (_pastControl) return _pastControl;

    if (@available(iOS 16.0, *)) {
        UIPasteControlConfiguration *configuration = [UIPasteControlConfiguration new];
        configuration.baseBackgroundColor = UIColor.greenColor;
        configuration.baseForegroundColor = UIColor.orangeColor;
        configuration.cornerStyle = UIButtonConfigurationCornerStyleCapsule;
        configuration.displayMode = UIPasteControlDisplayModeIconOnly;

        UIPasteControl *control = [[UIPasteControl alloc] initWithConfiguration:configuration];
        control.frame = CGRectMake(0, 100, 34, 34);
        [self.view addSubview:control];
        control.target = self.textView;
        _pastControl = control;

        [control printfAllVar];
        id _secureController = [control valueForKeyPath:@"_secureController"];
    }

    return _pastControl;
}


@end
