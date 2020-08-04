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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YXCController *controller = [YXCController new];
    [self.navigationController pushViewController:controller animated:YES];
}

/// 创建UI
- (void)setupUI {
    
    
}

@end
