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
#import "YXCBigPictureView.h"

@interface YXCPhotoListController ()<UICollectionViewDataSource, UICollectionViewDelegate, YXCPhotoListImageCellDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<YXCAssetModel *> *dataSources;
@property (nonatomic, strong) NSMutableArray<YXCAssetModel *> *selectedArray; /**< 选中照片 */

@end

@implementation YXCPhotoListController

{
    CGSize _itemSize; // 每个 Item 的宽高
}

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _itemSize = CGSizeMake(IPHONE_WIDTH * 0.25, IPHONE_WIDTH * 0.25);
    self.selectedArray = [NSMutableArray array];
    
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
    [YXCPhotoHandler getAlbumsPhotoWithCollection:collection complete:^(NSArray<YXCAssetModel *> *photos) {
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
    YXCAssetModel *model = self.dataSources[indexPath.row];
    cell.assetModel = model;
    cell.delegate = self;
    NSInteger index = [self.selectedArray indexOfObject:model];
    if (index >= 0 && index < self.selectedArray.count) {
        cell.selectedTitle = [NSString stringWithFormat:@"%ld", index + 1];
    } else {
        cell.selectedTitle = nil;
    }
    
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [YXCBigPictureView showWithAssetModel:self.dataSources[indexPath.row]];
}


#pragma mark - YXCPhotoListImageCellDelegate

- (void)listImageCell:(YXCPhotoListImageCell *)cell didSelectedWithAssetModel:(YXCAssetModel *)assetModel {
    
    if ([self.selectedArray containsObject:assetModel]) {
        [self.selectedArray removeObject:assetModel];
    } else {
        [self.selectedArray addObject:assetModel];
    }
    
    [self.collectionView reloadData];
}


#pragma mark - UI

- (void)setupUI {
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.itemSize = _itemSize;
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
