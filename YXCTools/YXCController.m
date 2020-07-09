//
//  YXCController.m
//  YXCTools
//
//  Created by GGT on 2020/7/9.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCController.h"
#import "YXCPerson.h"

@interface YXCController ()

@property (nonatomic, strong) UIView *redView; /**< <#desc#> */

@end

@implementation YXCController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self useUIViewCategory];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat borderWidth = arc4random_uniform(10);
    UIColor *color = [UIColor colorWithRed:arc4random() % 255 /255.0f green:arc4random() % 255 /255.0f blue:arc4random() % 255 /255.0f alpha:1.0f];
    self.redView.yxc_border = arc4random_uniform(20) & YXCViewBorderAll;
    self.redView.yxc_borderWidth = borderWidth;
    self.redView.yxc_borderColor = color;
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - UIView+Category

- (void)useUIViewCategory {
    
    UIView *redView = [UIView new];
    redView.width = 100;
    redView.height = 100;
    redView.center = self.view.center;
    redView.backgroundColor = [UIColor grayColor];
    redView.yxc_border = YXCViewBorderAll;
    redView.yxc_borderWidth = 2.0f;
    redView.yxc_borderColor = [UIColor redColor];
    [self.view addSubview:redView];
    self.redView = redView;
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

#pragma mark - UITextView+Category

- (void)userTextViewCategory {
    
    UITextView *textView = [UITextView new];
    textView.yxc_placeHolder = @"请输入您的内容";
    textView.font = [UIFont systemFontOfSize:15.0f];
    textView.width = 300;
    textView.height = 40;
    textView.backgroundColor = [UIColor orangeColor];
    textView.center = self.view.center;
    [self.view addSubview:textView];
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
