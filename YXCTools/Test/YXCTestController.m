//
//  YXCTestController.m
//  YXCTools
//
//  Created by GGT on 2021/2/3.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestController.h"
#import "YXCRunLoopHandler.h"
#import "YXCTestViewModel.h"

@interface YXCTestController ()<UITextFieldTextMaxLengthDelegate, UITextFieldDelegate>

@property (nonatomic, strong) YXCRunLoopHandler *runLoopHandler;
@property (nonatomic, strong) YXCTestViewModel *viewModel;

@end

@implementation YXCTestController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
    [self performSelectorTest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    [self setupUI];
    [self setupConstraints];
    [self performSelectorTest];
    
    [self.viewModel requestData:^{
        NSLog(@"数据请求成功，刷新UI");
    }];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)performSelectorTest {
    
    NSLog(@"%s", __func__);
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self performSelectorOnMainThread:@selector(performSelectorResponseMethod:) withObject:@"第一个参数" waitUntilDone:NO modes:@[NSRunLoopCommonModes, NSDefaultRunLoopMode]];
    });
    [self performSelectorResponseMethod:@"主线程调用"];
}

- (void)performSelectorResponseMethod:(NSString *)string {
    
    NSLog(@"currentThread : %@", [NSThread currentThread]);
    NSLog(@"argument_01 : %@", string);
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    UIButton *button = [UIButton new];
    button.yxc_colors = @[(__bridge id)UIColor.redColor.CGColor,
                          (__bridge id)UIColor.purpleColor.CGColor,
                          (__bridge id)UIColor.blueColor.CGColor];
    button.yxc_endPoint = CGPointMake(1, 0);
    button.yxc_locations = @[@0.3, @0.6];
    button.layer.cornerRadius = 5.0f;
    button.layer.masksToBounds = YES;
    [button setTitle:@"设置渐变颜色 UIButton" forState:UIControlStateNormal];
    [self.view addSubview:button];
    button.width = 300;
    button.height = 40;
    button.center = self.view.center;
    button.yxc_border = YXCViewBorderBottom;
    button.yxc_borderColor = UIColor.orangeColor;
    button.yxc_borderWidth = 3.0f;

    UILabel *label = [UILabel new];
    label.text = @"设置渐变颜色 Label";
    label.textColor = UIColor.orangeColor;
    label.textAlignment = NSTextAlignmentCenter;
    label.yxc_colors = @[(__bridge id)UIColor.grayColor.CGColor,
                         (__bridge id)UIColor.lightTextColor.CGColor,
                          (__bridge id)UIColor.lightGrayColor.CGColor];
    label.yxc_endPoint = CGPointMake(1, 0);
    label.yxc_locations = @[@0.3, @0.6];
    [self.view addSubview:label];
    label.width = 300;
    label.height = 40;
    label.centerX = self.view.centerX;
    label.top = button.bottom + 30;
}


#pragma mark - Constraints

- (void)setupConstraints {

    
}


#pragma mark - 懒加载

@end
