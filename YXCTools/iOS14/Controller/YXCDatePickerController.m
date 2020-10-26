//
//  YXCDatePickerController.m
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCDatePickerController.h"
#import "YXCDatePickerView.h"
#import "YXCMarqueeLabel.h"

@interface YXCDatePickerController ()

@end

@implementation YXCDatePickerController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
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


#pragma mark - UI

- (void)setupUI {
    
    YXCDatePickerView *datePickerView = [[YXCDatePickerView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:datePickerView];
    
    YXCMarqueeLabel *marqueeLabel = [YXCMarqueeLabel new];
    marqueeLabel.width = 250;
    marqueeLabel.height = 30;
    marqueeLabel.center = self.view.center;
    marqueeLabel.backgroundColor = UIColor.redColor;
    marqueeLabel.text = @"一生一代一双人，争教两处销魂。相思相望不相亲，天为谁春?";
    [self.view addSubview:marqueeLabel];
}



#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
