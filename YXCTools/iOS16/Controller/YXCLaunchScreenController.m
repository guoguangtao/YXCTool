//
//  YXCLaunchScreenController.m
//  YXCTools
//
//  Created by guogt on 2022/9/8.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCLaunchScreenController.h"
#import "AppDelegate.h"

@interface YXCLaunchScreenController ()

@property (nonatomic, strong) UIView *redView;              /**< redView */
@property (nonatomic, strong) UIButton *changeButton;       /**< 横竖屏切换按钮 */

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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    
    [self setupUI];
    [self setupConstraints];
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

- (void)dealloc {
    
    NSLog(@"%@", self);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)changeButtonCliked {
    
    [self p_switchOrientationWithLaunchScreen:!self.changeButton.isSelected];
    self.changeButton.selected = !self.changeButton.isSelected;
}


#pragma mark - Public


#pragma mark - Private

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
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {

    // redView
    self.redView = [UIView new];
    self.redView.backgroundColor = UIColor.redColor;
    [self.view addSubview:self.redView];

    // changeButton
    self.changeButton = [UIButton new];
    self.changeButton.backgroundColor = UIColor.orangeColor;
    [self.changeButton setTitle:@"切换横屏" forState:UIControlStateNormal];
    [self.changeButton setTitle:@"切换竖屏" forState:UIControlStateSelected];
    [self.changeButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [self.changeButton addTarget:self action:@selector(changeButtonCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.redView addSubview:self.changeButton];
}


#pragma mark - Constraints

- (void)setupConstraints {

    // redView
    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.left.right.equalTo(self.view);
        make.height.mas_equalTo(150);
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
