//
//  YXCCAReplicatorLayerController.m
//  YXCTools
//
//  Created by lbkj on 2021/10/27.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCCAReplicatorLayerController.h"

@interface YXCCAReplicatorLayerController ()

@end

@implementation YXCCAReplicatorLayerController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
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
    
    
}

/// 音乐播放器动画
- (void)volumnBarsAnimation {
    
    CAReplicatorLayer *layer = [CAReplicatorLayer new];
    layer.bounds = CGRectMake(0, 0, 60, 60);
    layer.position = self.view.center;
    layer.backgroundColor = UIColor.lightGrayColor.CGColor;
    [self.view.layer addSublayer:layer];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - Lazy


@end
