//
//  YXCImageSynthesisController.m
//  YXCTools
//
//  Created by guogt on 2024/8/23.
//  Copyright © 2024 GGT. All rights reserved.
//

#import "YXCImageSynthesisController.h"

@interface YXCImageSynthesisController ()

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *picture1;
@property (nonatomic, strong) UIImageView *picture2;
@property (nonatomic, strong) UIButton *saveButton;

@property (nonatomic, assign) CGSize picture1Size;
@property (nonatomic, assign) CGSize picture2Size;

@end

@implementation YXCImageSynthesisController

/// 刷新UI
- (void)injected {
    
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)saveButtonClicked {
    
    [self.picture1 saveToAlbum];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.picture1Size = CGSizeMake(1920, 1080);
    self.picture2Size = CGSizeMake(700, 440);
    
    self.saveButton = [UIButton new];
    self.saveButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [self.saveButton addTarget:self action:@selector(saveButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.saveButton setTitleColor:UIColor.orangeColor forState:UIControlStateNormal];
    [self.saveButton setTitle:@"保存" forState:UIControlStateNormal];
    [self.view addSubview:self.saveButton];
    
    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.zoomScale = 0.5;
    [self.view addSubview:self.scrollView];
    
    self.picture1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1.jpg"]];
    self.picture1.contentMode = UIViewContentModeScaleAspectFit;
    [self.scrollView addSubview:self.picture1];
    
    self.picture2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@""]];
    self.picture2.contentMode = UIViewContentModeScaleAspectFit;
    self.picture2.contentScaleFactor = [UIScreen mainScreen].scale;
    self.picture2.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.picture2.layer.cornerRadius = 10.0;
    self.picture2.layer.masksToBounds = true;
    [self.picture1 addSubview:self.picture2];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(100);
    }];
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.right.equalTo(self.view);
        make.top.equalTo(self.view).offset(150);
    }];
    
    [self.picture1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
    }];
    
    [self.picture2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.picture1).offset(850);
        make.top.equalTo(self.picture1).offset(410);
        make.width.mas_equalTo(self.picture2Size.width);
        make.height.mas_equalTo(self.picture2Size.height);
    }];
}


#pragma mark - Lazy


@end
