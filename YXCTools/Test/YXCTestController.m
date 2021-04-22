//
//  YXCTestController.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestController.h"

@interface YXCTestController ()


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

- (void)buttonClicked {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"结果" message:@"按钮被点击了" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    CGFloat fontSize = 50;
    UILabel *label = [UILabel new];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.attributedText = [NSMutableAttributedString new]
    .yxc_addImageAttributedAndFont([UIImage imageNamed:@"page_currentImage"], [UIFont systemFontOfSize:fontSize])
    .yxc_appendString(@"123", @{NSFontAttributeName : [UIFont systemFontOfSize:fontSize], NSForegroundColorAttributeName : UIColor.orangeColor})
    .yxc_addImageAttributedWithNameAndFontSize(@"calendar", fontSize)
    .yxc_addImageAttributedWithNameAndFontSize(@"green_pop", fontSize);
    [self.view addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.view);
        make.left.equalTo(self.view).offset(20);
        make.right.equalTo(self.view).offset(-20);
    }];
}


#pragma mark - Constraints

- (void)setupConstraints {

    
}


#pragma mark - 懒加载

@end
