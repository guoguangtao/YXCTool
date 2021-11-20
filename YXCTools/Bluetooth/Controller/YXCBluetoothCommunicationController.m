//
//  YXCBluetoothCommunicationController.m
//  YXCTools
//
//  Created by lbkj on 2021/11/20.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBluetoothCommunicationController.h"
#import "YXCBlueToothManager.h"

@interface YXCBluetoothCommunicationController ()

@property (nonatomic, strong) UITextView *inputView;
@property (nonatomic, strong) UILabel *readLabel;

@end

@implementation YXCBluetoothCommunicationController

/// 刷新UI
- (void)injected {
    
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    [[YXCBlueToothManager shareInstance] cancelPeripheralConnection:nil];
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)sendButtonClicked {
    [[YXCBlueToothManager shareInstance] sendText:self.inputView.text];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    UIButton *sendButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 40)];
    sendButton.yxc_setTitle(@"发送", UIControlStateNormal)
    .yxc_setTitleColor(UIColor.systemBlueColor, UIControlStateNormal)
    .yxc_setFontSize(15)
    .yxc_addAction(self, @selector(sendButtonClicked), UIControlEventTouchUpInside);
    UIBarButtonItem *sendItem = [[UIBarButtonItem alloc] initWithCustomView:sendButton];
    self.navigationItem.rightBarButtonItems = @[sendItem];
    
    self.inputView = [UITextView new];
    self.inputView.font = [UIFont systemFontOfSize:15];
    self.inputView.backgroundColor = UIColor.grayColor;
    [self.view addSubview:self.inputView];
    
    self.readLabel = [UILabel new];
    self.readLabel.font = [UIFont systemFontOfSize:14.0f];
    self.readLabel.numberOfLines = 0;
    [self.view addSubview:self.readLabel];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_topMargin).offset(10);
        make.left.equalTo(self.view.mas_leftMargin).offset(10);
        make.right.equalTo(self.view.mas_rightMargin).offset(-10);
        make.bottom.equalTo(self.view.mas_centerY).offset(-10);
    }];
    
    [self.readLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputView.mas_bottom).offset(10);
        make.left.right.equalTo(self.inputView);
        make.bottom.equalTo(self.view.mas_bottomMargin);
    }];
}


#pragma mark - Lazy


@end
