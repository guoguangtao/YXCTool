//
//  YXCTestController.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestController.h"

@interface YXCTestController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation YXCTestController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
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
    
    self.label = [UILabel new];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.label.attributedText = [NSMutableAttributedString new]
    .yxc_appendString(@"123", @{NSForegroundColorAttributeName : UIColor.redColor, NSFontAttributeName : [UIFont systemFontOfSize:20]})
    .yxc_appendAttributedString([NSMutableAttributedString new].yxc_appendString(@"456", @{NSForegroundColorAttributeName : UIColor.orangeColor, NSFontAttributeName : [UIFont systemFontOfSize:40]}))
    .yxc_appendString(@"789", @{NSForegroundColorAttributeName : UIColor.purpleColor})
    .yxc_modifyAttributedString(@"456", @{NSForegroundColorAttributeName : UIColor.blueColor});
    [self.view addSubview:self.label];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
}


#pragma mark - 懒加载

@end
