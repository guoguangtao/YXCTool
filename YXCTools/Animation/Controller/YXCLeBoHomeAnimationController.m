//
//  YXCLeBoHomeAnimationController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCLeBoHomeAnimationController.h"

@interface YXCLeBoHomeAnimationController ()

@property (nonatomic, strong) UITableView *tableView; /**< tableView */
@property (nonatomic, strong) UIView *navigationView; /**< 导航视图 */

@end

@implementation YXCLeBoHomeAnimationController

- (void)injected {
    
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"乐播首页动画";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)setupUI {
    
    
}

- (void)setupConstraints {
    
    
}

@end
