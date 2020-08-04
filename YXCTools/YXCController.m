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
    
    [self.view yxc_removeAllSubView];
    
    [self useUIViewCategory];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - UIView+Category

- (void)useUIViewCategory {
    
    self.navigationItem.rightBarButtonItems = nil;
    
    UIButton *button = [UIButton new];
    [button setTitle:@"保存" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveToAlbum) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[item];
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)];
    redView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:redView];
    self.redView = redView;
    
    YXCButton *btn = [YXCButton new];
    btn.yxc_space = 20;
    btn.yxc_imagePosition = YXCButtonImagePositionTop;
    btn.titleLabel.font = [UIFont systemFontOfSize:25 weight:UIFontWeightMedium];
    [btn setImage:[UIImage imageNamed:@"live"] forState:UIControlStateNormal];
    [btn setTitle:@"品   播" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:43.0f / 255.0f
                                       green:133.0f / 255.0f
                                        blue:250.0f / 255.0f
                                       alpha:1.0f]
              forState:UIControlStateNormal];
    [redView addSubview:btn];
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(redView);
    }];
}

- (void)saveToAlbum {
    
    [self.redView saveToAlbum];
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
