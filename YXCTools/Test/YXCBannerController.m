//
//  YXCBannerController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBannerController.h"
#import "YXCBannerCell.h"
#import "UIScrollView+YXC_Category.h"

@interface YXCBannerController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;   /**< CollectionView layout */
@property (nonatomic, strong) UICollectionView *collectionView;     /**< CollectionView */
@property (nonatomic, strong) UIButton *startButton;                /**< 开始滚动按钮 */

@end

@implementation YXCBannerController

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)startScroll {
    
    CGFloat width = self.layout.itemSize.width + self.layout.minimumLineSpacing;
    CGFloat offsetX = width + self.collectionView.contentOffset.x;
    CGPoint point = CGPointMake(offsetX, 0);
    
    [self.collectionView yxc_setContentOffset:point duration:1.0f timingFunction:YXCScrollTimingFunctionSineInOut completion:nil];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return MAXINTERP;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.text = @(indexPath.row).stringValue;
    
    return cell;
}

#pragma mark - UICollectionViewDelegate


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (self.collectionView != scrollView) {
        return;
    }
    
    NSArray *visibleCells = [self.collectionView visibleCells];
    for (YXCBannerCell *cell in visibleCells) {
        [cell yxc_animationWithScrollView:scrollView layout:self.layout];
    }
}


#pragma mark - UI

- (void)setupUI {
    
    self.layout = [UICollectionViewFlowLayout new];
    self.layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.layout.itemSize = CGSizeMake(CGRectGetWidth(UIScreen.mainScreen.bounds) - 20, 180);
    self.layout.minimumLineSpacing = 20;
    self.layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = UIColor.systemBackgroundColor;
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    [self.collectionView registerClass:YXCBannerCell.class forCellWithReuseIdentifier:kCellIdentifier];
    [self.view addSubview:self.collectionView];
    
    self.startButton = [UIButton new];
    self.startButton.yxc_setTitle(@"滚动", UIControlStateNormal)
    .yxc_setBackgroundColor(UIColor.blueColor, UIControlStateNormal)
    .yxc_setCornerRadius(10.0f)
    .yxc_addAction(self, @selector(startScroll), UIControlEventTouchUpInside);
    [self.view addSubview:self.startButton];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.mas_equalTo(200);
        make.width.mas_equalTo(self.view);
    }];
    
    [self.startButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.top.equalTo(self.view.mas_topMargin).offset(50);
    }];
}


#pragma mark - Lazy


@end
