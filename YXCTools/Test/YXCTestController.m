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

#pragma mark - UITextFieldTextMaxLengthDelegate

- (void)textField:(UITextField *)textField textDidChange:(NSString *)text textLength:(NSInteger)textLength textMaxLength:(NSInteger)textMaxLength {
    
    YXCLog(@"文本:%@, 文本长度:%ld", text, textLength);
}


#pragma mark - UI

- (void)setupUI {
    
    UITextField *textFiled = [[UITextField alloc] init];
    textFiled.borderStyle = UITextBorderStyleRoundedRect;
    textFiled.backgroundColor = UIColor.orangeColor;
    textFiled.textMaxLength = 10;
    textFiled.yxc_delegate = self;
    textFiled.delegate = self;
    [self.view addSubview:textFiled];
    
    [textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(250);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark - Constraints

- (void)setupConstraints {

    
}


#pragma mark - 懒加载

@end
