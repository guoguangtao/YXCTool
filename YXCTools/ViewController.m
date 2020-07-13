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
    
    [self setupLabel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupLabel];
}

- (void)setupLabel {
    
    NSString *text = @"这是在iPhone6设计稿15号字体";
    
    UILabel *label1 = [UILabel new];
    label1.textColor = [UIColor orangeColor];
    label1.text = text;
    label1.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0f green:arc4random() % 255 /255.0f blue:arc4random() % 255 /255.0f alpha:1.0f];
    label1.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightBold];
    [self.view addSubview:label1];
    CGSize size1 = [label1 sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    label1.width = size1.width;
    label1.height = size1.height;
    label1.centerX = self.view.centerX;
    label1.bottom = 100;
    
    UILabel *label2 = [UILabel new];
    label2.textColor = [UIColor orangeColor];
    label2.backgroundColor = [UIColor colorWithRed:arc4random() % 255 /255.0f green:arc4random() % 255 /255.0f blue:arc4random() % 255 /255.0f alpha:1.0f];
    label2.text = text;
    label2.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:label2];
    CGSize size2 = [label2 sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    label2.width = size2.width;
    label2.height = size2.height;
    label2.centerX = self.view.centerX;
    label2.bottom = 200;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YXCController *controller = [YXCController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
