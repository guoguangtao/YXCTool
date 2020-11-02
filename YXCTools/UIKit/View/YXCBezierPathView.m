//
//  YXCBezierPathView.m
//  YXCTools
//
//  Created by GGT on 2020/11/2.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCBezierPathView.h"
#import "UIView+YXC_Category.h"

@interface YXCBezierPathView ()

@end

@implementation YXCBezierPathView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
