//
//  ViewController.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "ViewController.h"
#import "YXCPerson.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self useUIControlCategory];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    YXCLog(@"%@", [UIDevice currentDevice].platformName);
}

- (void)logIsBangsScreen {
    
    YXCLog(@"%@刘海屏幕", kIsBangsScreen ? @"是" : @"不是");
}

- (void)logWindows:(NSString *)methodString {
    
    YXCLog(@"=========================================================");
    
    YXCLog(@"%@ --- windows = %@", methodString, [UIApplication sharedApplication].windows);
    YXCLog(@"%@ --- keyWindow = %@", methodString, [UIApplication sharedApplication].keyWindow);
    YXCLog(@"%@ --- delegate.window = %@", methodString, [UIApplication sharedApplication].delegate.window);
}


#pragma mark - UIView+Category

- (void)useUIViewCategory {
    
    UIView *redView = [UIView new];
    redView.width = 50;
    redView.height = 50;
    redView.center = self.view.center;
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
}

#pragma mark - NSArray+Category / NSDictionary+Category

- (void)useNSArrayCategory {
    
    YXCPerson *person = [YXCPerson new];
    person.name = @"张三";
    person.age = 20;
    person.height = 190;
    
    NSArray *array = @[@"1", @"2", @{@"测试" : @"这是内容"}, person];
    
    YXCLog(@"%@", array);
}

#pragma mark - UIControl+Category

- (void)useUIControlCategory {
    
    UIButton *button = [UIButton new];
    button.width = 100;
    button.height = 30;
    button.center = self.view.center;
    button.backgroundColor = kColorFromHexCode(0x0000FF);
    [button addTarget:self
               action:@selector(buttonClicked)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)buttonClicked {
    
    YXCLog(@"%s", __func__);
}


@end
