//
//  YXCLaunchImagesController.m
//  YXCTools
//
//  Created by GGT on 2020/10/20.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCLaunchImagesController.h"

@interface YXCLaunchImagesController ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation YXCLaunchImagesController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}




#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)saveLaunchImage {
    
    [self.contentView saveToAlbum];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.contentView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.contentView];
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.image = [UIImage imageNamed:@"atten"];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.width = self.view.width - 250;
    self.imageView.height = self.view.height - 200;
    self.imageView.centerX = self.view.centerX;
    self.imageView.centerY = self.view.centerY - 50;
    [self.contentView addSubview:self.imageView];
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:20.0f];
    label.text = @"考勤记录每一天";
    label.textColor = kColorFromHexCode(0x3DC69D);
    label.size = [label sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    label.centerX = self.view.centerX;
    label.centerY = self.view.centerY + 50;
    [self.contentView addSubview:label];
    
    UIButton *button = [UIButton new];
    button.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    button.backgroundColor = [UIColor orangeColor];
    button.width = 100;
    button.height = 40;
    button.right = IPHONE_WIDTH - 30;
    button.top = 150;
    [button setTitle:@"保存图片" forState:UIControlStateNormal];
    [button setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [button addTarget:self action:@selector(saveLaunchImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];

}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
