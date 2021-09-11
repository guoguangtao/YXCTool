//
//  YXCLeBoHomeAnimationController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCLeBoHomeAnimationController.h"

static CGFloat const AnimationViewHeight = 100; /**< 动画View的高度 */
static CGFloat const AnimationViewWidth = 200; /**< 动画View的宽度 */

@interface YXCLeBoHomeAnimationController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *navigationView; /**< 导航栏 */
@property (nonatomic, strong) UITableView *tableView; /**< tableView */

@property (nonatomic, strong) UIView *animationBackgroundView; /**< 动画 */
@property (nonatomic, strong) UIButton *connectButton;  /**< 连接设备名称 */
@property (nonatomic, strong) UIButton *startPlayButton; /**< 开始投屏按钮 */

@end

@implementation YXCLeBoHomeAnimationController

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
    [self setupConstraints];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)buttonClicked {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)startAnimation {
    
    
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.contentView.backgroundColor = UIColor.grayColor;
    
    return cell;
}

#pragma mark - UITableViewDelegate


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView != self.tableView) {
        return;
    }
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < 0) {
        // 计算frame属性
        CGFloat scale = (AnimationViewHeight + offsetY) / AnimationViewHeight;
        // 计算y值
        CGFloat y = CGRectGetMaxY(self.navigationView.frame) - CGRectGetHeight(self.navigationView.frame) * scale;
        self.animationBackgroundView.y = y;
        // 计算height值
        CGFloat height = AnimationViewHeight - (AnimationViewHeight - CGRectGetHeight(self.navigationView.frame)) * scale;
        self.animationBackgroundView.height = MIN(height, AnimationViewHeight);
        // 计算 width 值
        CGFloat width = (CGRectGetWidth(self.navigationView.frame) - AnimationViewWidth) * scale + AnimationViewWidth;
        self.animationBackgroundView.width = MAX(width, AnimationViewWidth);
        // 计算centerX值
        self.animationBackgroundView.centerX = self.navigationView.centerX;
    } else {
        self.animationBackgroundView.y = CGRectGetMinY(self.navigationView.frame);
        self.animationBackgroundView.height = CGRectGetHeight(self.navigationView.frame);
        self.animationBackgroundView.width = CGRectGetWidth(self.navigationView.frame);
        self.animationBackgroundView.centerX = CGRectGetMidX(self.navigationView.frame);
    }
}


#pragma mark - UI

- (void)setupUI {
    
    [self.view addSubview:self.navigationView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.animationBackgroundView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.navigationView.mas_bottom);
    }];
}


#pragma mark - Lazy

- (UITableView *)tableView {
    
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.rowHeight = 80;
    _tableView.delegate = self;
    _tableView.contentInset = UIEdgeInsetsMake(AnimationViewHeight, 0, 0, 0);
    _tableView.contentOffset = CGPointMake(0, -AnimationViewHeight);
    _tableView.backgroundColor = UIColor.whiteColor;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    return _tableView;
}

- (UIView *)animationBackgroundView {
    
    if (_animationBackgroundView) {
        return _animationBackgroundView;
    }
    
    _animationBackgroundView = [UIView new];
    _animationBackgroundView.backgroundColor = UIColor.orangeColor;
    _animationBackgroundView.frame = CGRectMake(CGRectGetMidX(self.view.frame), CGRectGetMaxY(self.navigationView.frame), AnimationViewWidth, AnimationViewHeight);
    _animationBackgroundView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(_animationBackgroundView.frame));
    
    self.connectButton = [UIButton new];
    [self.connectButton setImage:[UIImage imageNamed:@"emitter_like"] forState:UIControlStateNormal];
    [self.connectButton setTitle:@"乐播客厅电视" forState:UIControlStateNormal];
    [_animationBackgroundView addSubview:self.connectButton];
    CGSize buttonSize = [self.connectButton sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.connectButton.size = buttonSize;
    self.connectButton.left = (_animationBackgroundView.width - self.connectButton.width) * 0.5f;
    self.connectButton.top = 20;
    
    return _animationBackgroundView;
}

- (UIView *)navigationView {
    
    if (_navigationView) {
        return _navigationView;
    }
    
    _navigationView = [UIView new];
    _navigationView.backgroundColor = UIColor.redColor;
    _navigationView.frame = CGRectMake(0, 44, CGRectGetWidth(self.view.frame), 64);
    
    UIButton *button = [UIButton new];
    button.backgroundColor = UIColor.purpleColor;
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_navigationView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_navigationView).offset(20);
        make.width.height.mas_equalTo(44);
        make.centerY.equalTo(_navigationView);
    }];
    
    return _navigationView;
}


@end
