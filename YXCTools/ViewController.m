//
//  ViewController.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "ViewController.h"
#import "YXCController.h"

@interface ViewController ()

@end

@implementation ViewController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YXCController *controller = [YXCController new];
    [self.navigationController pushViewController:controller animated:YES];
}

/// 创建UI
- (void)setupUI {
    
    UIButton *button = [UIButton new];
    button.backgroundColor = UIColor.orangeColor;
    button.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [button setTitle:@"相机/相册访问" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(50);
    }];
}

- (void)buttonClicked {
    
    [[YXCImagePickerHandler shareImagePicker] choosePhotoOrCameraWithController:self allowsEditing:YES complete:^(UIImage *image, NSDictionary *info) {

    }];
}

@end
