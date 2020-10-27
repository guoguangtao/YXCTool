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
    marqueeLabel.beginDelay = 1;
    marqueeLabel.pauseDelay = 2;
    marqueeLabel.scrollVelocity = 100;
    marqueeLabel.text = @"一生一代一双人，争教两处销魂。相思相望不相亲，天为谁春?";
    [self.view addSubview:marqueeLabel];
    
    YXCMarqueeLabel *marqueeLabel1 = [YXCMarqueeLabel new];
    marqueeLabel1.width = 300;
    marqueeLabel1.height = 30;
    marqueeLabel1.centerX = self.view.centerX;
    marqueeLabel1.centerY = self.view.centerY + 50;
    marqueeLabel1.backgroundColor = UIColor.redColor;
    marqueeLabel1.beginDelay = 1;
    marqueeLabel1.pauseDelay = 2;
    marqueeLabel1.scrollVelocity = 100;
    marqueeLabel1.text = @"一生一代一双人，争教两处销魂。";
    [self.view addSubview:marqueeLabel1];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [marqueeLabel stopAnimation];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [marqueeLabel beginAnimation];
        });
    });
}



#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
