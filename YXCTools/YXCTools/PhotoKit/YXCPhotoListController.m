//
//  YXCPhotoListController.m
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoListController.h"
#import "YXCPhotoView.h"

@interface YXCPhotoListController ()



@end

@implementation YXCPhotoListController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [[YXCImagePickerHandler shareImagePicker] choosePhotoOrCameraWithController:self allowsEditing:NO complete:nil];
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    YXCPhotoView *photoView = [[YXCPhotoView alloc] initWithFrame:self.view.bounds];
    photoView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:photoView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
