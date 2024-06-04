//
//  YXCLaunchScreenController.m
//  YXCTools
//
//  Created by guogt on 2022/9/8.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCLaunchScreenController.h"
#import "YXCBigPictureCell.h"
#import "YXCPhotoHandler.h"
#import "YXCAssetModel.h"
#import "AppDelegate.h"

@interface YXCLaunchScreenController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UIView *redView;              /**< redView */
@property (nonatomic, strong) UIButton *changeButton;       /**< 横竖屏切换按钮 */
@property (nonatomic, strong) UICollectionView *colletionView;
@property (nonatomic, strong) NSArray<YXCAssetModel *> *dataSources;
@property (nonatomic, assign) CGSize itemSize;
@property (nonatomic, assign) NSInteger currentIndex;

@end

@implementation YXCLaunchScreenController

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
    
    self.title = @"横竖屏切换";
    self.itemSize = self.view.size;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    
    [self setupUI];
    [self setupConstraints];
    [self getPhotos];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
    
    NSLog(@"view 发生改变:%@", NSStringFromCGSize(size));
    BOOL isLaunchScreen = NO;
    if (@available(iOS 16.0, *)) {
        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
        UIWindowScene *scene = [array firstObject];
        isLaunchScreen = scene.interfaceOrientation == UIInterfaceOrientationLandscapeRight;
    } else {
        // 这里是 UIDeviceOrientationLandscapeLeft（我们需要 Home 按键在右边）
        // UIDeviceOrientationLandscapeLeft,       // Device oriented horizontally, home button on the right
        isLaunchScreen = [UIDevice currentDevice].orientation == UIDeviceOrientationLandscapeLeft;
    }
    
    NSLog(@"将要%@", isLaunchScreen ? @"横屏" : @"竖屏");
    [self p_updateViewWithIsLaunchScreen:isLaunchScreen size:size];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    [super traitCollectionDidChange:previousTraitCollection];
    
    CGFloat contentSizeWidth = self.itemSize.width * (self.dataSources.count);
    self.colletionView.contentSize = CGSizeMake(contentSizeWidth, 0);
    CGPoint contentOffset = CGPointMake(self.currentIndex * self.itemSize.width, 0);
    NSLog(@"设置索引 : %ld itemSize : %@ 偏移量 : %@", self.currentIndex, NSStringFromCGSize(self.itemSize), NSStringFromCGPoint(contentOffset));
    self.colletionView.contentOffset = contentOffset;
}

- (void)dealloc {
    
    NSLog(@"%@", self);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setDataSources:(NSArray<YXCAssetModel *> *)dataSources {
    _dataSources = dataSources;
    
    [self.colletionView reloadData];
}


#pragma mark - IBActions

- (void)changeButtonCliked {
    
    self.currentIndex = self.colletionView.contentOffset.x / self.colletionView.size.width;
    NSLog(@"当前索引 : %ld", self.currentIndex);
    [self p_switchOrientationWithLaunchScreen:!self.changeButton.isSelected];
    self.changeButton.selected = !self.changeButton.isSelected;
}


#pragma mark - Public


#pragma mark - Private

- (void)getPhotos {
    
    // 先查看相册是否授权
    BOOL authorizationStatus = [YXCPhotoHandler photoAuthorizationStatus:^(PHAuthorizationStatus status) {
        // 第一次授权,等待授权操作完成
        [self getPhotos];
    }];
    
    // 未授权
    if (!authorizationStatus) return;
    
    [YXCPhotoHandler getAllPhotoAlbumsComplete:^(NSArray<NSDictionary *> *assetArray) {
        NSLog(@"%@", assetArray);
        for (NSDictionary *dict in assetArray) {
            NSString *title = dict[@"name"];
            if ([title isEqualToString:@"Recents"]) {
                PHAssetCollection *collection = dict[@"collection"];
                [YXCPhotoHandler getAlbumsPhotoWithCollection:collection complete:^(NSArray<YXCAssetModel *> *photos) {
                    self.dataSources = photos;
                }];
            }
        }
    }];
}

/// 切换设备方向
/// - Parameter isLaunchScreen: 是否是全屏
- (void)p_switchOrientationWithLaunchScreen:(BOOL)isLaunchScreen {
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (isLaunchScreen) {
        // 全屏操作
        appdelegate.launchScreen = YES;
    } else {
        // 退出全屏操作
        appdelegate.launchScreen = NO;
    }
    
    if (@available(iOS 16.0, *)) {
        void (^errorHandler)(NSError *error) = ^(NSError *error) {
                    NSLog(@"强制%@错误:%@", isLaunchScreen ? @"横屏" : @"竖屏", error);
                };
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                SEL supportedInterfaceSelector = NSSelectorFromString(@"setNeedsUpdateOfSupportedInterfaceOrientations");
                [self performSelector:supportedInterfaceSelector];
                NSArray *array = [[UIApplication sharedApplication].connectedScenes allObjects];
                UIWindowScene *scene = (UIWindowScene *)[array firstObject];
                Class UIWindowSceneGeometryPreferencesIOS = NSClassFromString(@"UIWindowSceneGeometryPreferencesIOS");
                if (UIWindowSceneGeometryPreferencesIOS) {
                    SEL initWithInterfaceOrientationsSelector = NSSelectorFromString(@"initWithInterfaceOrientations:");
                    UIInterfaceOrientationMask orientation = isLaunchScreen ? UIInterfaceOrientationMaskLandscapeRight : UIInterfaceOrientationMaskPortrait;
                    id geometryPreferences = [[UIWindowSceneGeometryPreferencesIOS alloc] performSelector:initWithInterfaceOrientationsSelector withObject:@(orientation)];
                    if (geometryPreferences) {
                        SEL requestGeometryUpdateWithPreferencesSelector = NSSelectorFromString(@"requestGeometryUpdateWithPreferences:errorHandler:");
                        if ([scene respondsToSelector:requestGeometryUpdateWithPreferencesSelector]) {
                            [scene performSelector:requestGeometryUpdateWithPreferencesSelector withObject:geometryPreferences withObject:errorHandler];
                        }
                    }
                }
        #pragma clang diagnostic pop
//        [self setNeedsUpdateOfSupportedInterfaceOrientations];
//        NSArray *array = [[[UIApplication sharedApplication] connectedScenes] allObjects];
//        UIWindowScene *scene = [array firstObject];
//        UIInterfaceOrientationMask orientation = isLaunchScreen ? UIInterfaceOrientationMaskLandscapeRight : UIInterfaceOrientationMaskPortrait;
//        UIWindowSceneGeometryPreferencesIOS *geometryPreferencesIOS = [[UIWindowSceneGeometryPreferencesIOS alloc] initWithInterfaceOrientations:orientation];
//        [scene requestGeometryUpdateWithPreferences:geometryPreferencesIOS errorHandler:^(NSError * _Nonnull error) {
//            NSLog(@"强制%@错误:%@", isLaunchScreen ? @"横屏" : @"竖屏", error);
//        }];
    } else {
        [self p_swichToNewOrientation:isLaunchScreen ? UIInterfaceOrientationLandscapeRight : UIInterfaceOrientationPortrait];
    }
}

/// iOS16 之前进行横竖屏切换方式
/// - Parameter interfaceOrientation: 需要切换的方向
- (void)p_swichToNewOrientation:(UIInterfaceOrientation)interfaceOrientation {
    
    //    NSNumber *resetOrientationTarget = [NSNumber numberWithInt:UIInterfaceOrientationUnknown];
    //    [[UIDevice currentDevice] setValue:resetOrientationTarget forKey:@"orientation"];
    NSNumber *orientationTarget = [NSNumber numberWithInteger:interfaceOrientation];
    [[UIDevice currentDevice] setValue:orientationTarget forKey:@"orientation"];
}

/// 适配横竖屏约束
/// - Parameters:
///   - isLaunchScreen: 是否是横屏
///   - size: 当前控制器 View 的 size 大小
- (void)p_updateViewWithIsLaunchScreen:(BOOL)isLaunchScreen size:(CGSize)size {

    if (isLaunchScreen) {
        // 横屏
        [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    } else {
        // 竖屏
        [self.redView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.left.right.equalTo(self.view);
            make.height.mas_equalTo(150);
        }];
    }
    
    self.itemSize = size;
    [self.colletionView.collectionViewLayout invalidateLayout];
}


#pragma mark - Protocol

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCBigPictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.blackColor;
    cell.assetModel = self.dataSources[indexPath.row];
    
    return cell;
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.itemSize;
}


#pragma mark - UI

- (void)setupUI {

    // redView
    self.redView = [UIView new];
    self.redView.backgroundColor = UIColor.redColor;
    self.redView.hidden = true;
    [self.view addSubview:self.redView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    self.colletionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.colletionView.dataSource = self;
    self.colletionView.delegate = self;
    self.colletionView.pagingEnabled = true;
    self.colletionView.backgroundColor = UIColor.blackColor;
    self.colletionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    [self.colletionView registerClass:[YXCBigPictureCell class] forCellWithReuseIdentifier:kCellIdentifier];
    [self.view addSubview:self.colletionView];

    // changeButton
    self.changeButton = [UIButton new];
    self.changeButton.backgroundColor = UIColor.orangeColor;
    [self.changeButton setTitle:@"切换横屏" forState:UIControlStateNormal];
    [self.changeButton setTitle:@"切换竖屏" forState:UIControlStateSelected];
    [self.changeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.changeButton addTarget:self action:@selector(changeButtonCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.changeButton];
}


#pragma mark - Constraints

- (void)setupConstraints {

    // redView
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.right.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    [self.colletionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    // changeButton
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.redView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(50);
    }];
}


#pragma mark - Lazy


@end
