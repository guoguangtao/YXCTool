//
//  YXCBigPictureView.m
//  YXCTools
//
//  Created by GGT on 2020/10/9.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCBigPictureView.h"
#import "YXCAssetModel.h"
#import "YXCBigPictureCell.h"

@interface YXCBigPictureView ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation YXCBigPictureView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.9f];
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)]];
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setPhotos:(NSArray<YXCAssetModel *> *)photos {
    
    _photos = photos;
    
    [self.collectionView reloadData];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    
    _selectedIndex = selectedIndex;
    
    CGFloat offsetX = selectedIndex * IPHONE_WIDTH;
    self.collectionView.contentOffset = CGPointMake(offsetX, 0);
}


#pragma mark - IBActions


#pragma mark - Public

+ (instancetype)showWithAssetModels:(NSArray<YXCAssetModel *> *)photos
                      selectedIndex:(NSInteger)selectedIndex {
    
    YXCBigPictureView *bigPicView = [YXCBigPictureView new];
    bigPicView.photos = photos;
    bigPicView.selectedIndex = selectedIndex;
    
    NSArray *windows = [UIApplication sharedApplication].windows;
    
    for (UIWindow *window in windows) {
        if (window) {
            bigPicView.frame = window.bounds;
            [window addSubview:bigPicView];
            break;
        }
    }
    
    return bigPicView;
}

- (void)dismiss {
    
    [self removeFromSuperview];
}


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.photos.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCBigPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:YXCBigPictureCellIdentifier
                                                                        forIndexPath:indexPath];
    cell.assetModel = self.photos[indexPath.row];
    return cell;
    
    collectionView dequeueReusableSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#> forIndexPath:<#(nonnull NSIndexPath *)#>
}


#pragma mark - UI

- (void)setupUI {
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(IPHONE_WIDTH, IPHONE_HEIGHT);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0.0f;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, IPHONE_WIDTH, IPHONE_HEIGHT)
                                             collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.pagingEnabled = YES;
    [self.collectionView registerClass:[YXCBigPictureCell class]
            forCellWithReuseIdentifier:YXCBigPictureCellIdentifier];
    [self addSubview:self.collectionView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
