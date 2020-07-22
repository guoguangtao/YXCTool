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
    
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(kYXCPT(100), kYXCPT(100), kYXCPT(30), kYXCPT(30))];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *orangeView = [[UIView alloc] initWithFrame:CGRectMake(kYXCPX(200), kYXCPX(400), kYXCPX(60), kYXCPX(60))];
    orangeView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:orangeView];
    
    UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(100, 150, 30, 30)];
    blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 250, IPHONE_WIDTH, 50)];
    label.font = [UIFont systemFontOfSize:20 weight:UIFontWeightBold];
    label.text = @"15";
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 300, IPHONE_WIDTH, 50)];
    label1.font = [UIFont boldSystemFontOfSize:20];
    label1.text = @"15";
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
}

@end
