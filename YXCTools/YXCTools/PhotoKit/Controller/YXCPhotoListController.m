//
//  YXCPhotoListController.m
//  YXCTools
//
//  Created by GGT on 2020/9/25.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoListController.h"
#import "YXCPhotoListImageCell.h"
#import "YXCPhotoHandler.h"
#import <PhotosUI/PHPhotoLibrary+PhotosUISupport.h>

@interface YXCPhotoListController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<UIImage *> *dataSources;

@end

@implementation YXCPhotoListController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
    [self getPhotos];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)getPhotos {
    
    PHAssetCollection *collection = self.parameter[@"collection"];
    [YXCPhotoHandler getAlbumsPhotoWithCollection:collection complete:^(NSArray<UIImage *> *photos) {
        self.dataSources = photos;
        [self.collectionView reloadData];
    }];
}


#pragma mark - Protocol

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCPhotoListImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kPhotoListImageCellIdentifier
                                                                            forIndexPath:indexPath];
    cell.image = self.dataSources[indexPath.row];
    
    return cell;
}


#pragma mark - UICollectionViewDelegate


#pragma mark - UI

- (void)setupUI {
    
    CGFloat width = IPHONE_WIDTH * 0.25;
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(width, width);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[YXCPhotoListImageCell class] forCellWithReuseIdentifier:kPhotoListImageCellIdentifier];
    [self.view addSubview:self.collectionView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
