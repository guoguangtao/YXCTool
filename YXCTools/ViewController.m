//
//  ViewController.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "ViewController.h"
#import "YXCController.h"

@interface ViewController ()

@end

@implementation ViewController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

/// 创建UI
- (void)setupUI {
    
    NSArray *array = @[@"哈哈", @"嘿嘿"];
    YXCLog(@"%@", array);
    
    NSDictionary *dict = @{@"这是一个字典": @"哈哈哈"};
    YXCLog(@"%@", dict);
    
    YXCButton *button = [YXCButton new];
    button.yxc_imagePosition = YXCButtonImagePositionBottom;
    button.yxc_space = 15;
    button.titleLabel.font = [UIFont systemFontOfSize:40];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"calendar"] forState:UIControlStateNormal];
    [button setTitle:@"星期日" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

- (void)buttonClicked:(UIButton *)button {
    NSArray *days = @[@"一", @"二", @"三", @"四", @"五", @"六", @"日"];
    NSString *titleString = [NSString stringWithFormat:@"星期%@", days[arc4random_uniform(7)]];
    NSLog(@"%@", titleString);
    [button setTitle:titleString forState:UIControlStateNormal];
}

@end
