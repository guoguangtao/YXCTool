//
//  YXCPhotoAlbumListController.m
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoAlbumListController.h"
#import "YXCPhotoView.h"

@interface YXCPhotoAlbumListController ()



@end

@implementation YXCPhotoAlbumListController

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




#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    YXCPhotoView *photoView = [YXCPhotoView photoViewWithOwner:self];
    photoView.frame = self.view.bounds;
    [self.view addSubview:photoView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
