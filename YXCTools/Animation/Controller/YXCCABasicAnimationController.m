//
//  YXCCABasicAnimationController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCCABasicAnimationController.h"
#import "YXCBasicAnimation.h"

@interface YXCCABasicAnimationController ()<CAAnimationDelegate>

@property (nonatomic, strong) UIView *orangeView;   /**< 动画View */
@property (nonatomic, strong) UIButton *startAnimationButton;   /**< 开始动画按钮 */
@property (nonatomic, strong) YXCBasicAnimation *animationY;

@end

@implementation YXCCABasicAnimationController

/// 刷新UI
- (void)injected {
    
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
    self.animationY = nil;
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

/// 开始执行动画操作
- (void)startAnimationAction {
    
    [self.orangeView.layer removeAnimationForKey:@"animation"];
    [self.orangeView.layer addAnimation:self.animationY forKey:@"animation"];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - CAAnimationDelegate

/* Called when the animation begins its active duration. */

- (void)animationDidStart:(CAAnimation *)anim {
    
    YXCLog(@"%s", __func__);
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - UI

- (void)setupUI {
    
    // orangeView
    self.orangeView = [UIView new];
    self.orangeView.backgroundColor = UIColor.systemOrangeColor;
    [self.view addSubview:self.orangeView];
    
    // startAnimationButton
    self.startAnimationButton = [UIButton new];
    self.startAnimationButton.yxc_setBackgroundColor(UIColor.orangeColor, UIControlStateNormal)
    .yxc_setCornerRadius(8.0f)
    .yxc_setTitle(@"开始动画", UIControlStateNormal)
    .yxc_addAction(self, @selector(startAnimationAction), UIControlEventTouchUpInside);
    [self.view addSubview:self.startAnimationButton];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.orangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.width.height.mas_equalTo(50);
    }];
    
    [self.startAnimationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_topMargin).offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
}


#pragma mark - Lazy

- (YXCBasicAnimation *)animationY {
    
    if (_animationY) {
        return _animationY;
    }
    
    // 利用 CABasicAnimation 平移 CenterY
    YXCBasicAnimation *animationY = [YXCBasicAnimation animationWithKeyPath:@"position.y"];
    animationY.fromValue = @(CGRectGetMidY(self.orangeView.frame));
    animationY.toValue = @(CGRectGetMaxY(self.startAnimationButton.frame) + CGRectGetHeight(self.orangeView.frame));
    animationY.repeatCount = 1;
    animationY.duration = 1.25;
    animationY.autoreverses = NO; // 设置动画返回到原来的状态是否需要动画返回
    animationY.fillMode = kCAFillModeForwards;
    animationY.removedOnCompletion = NO; // 是否需要移除动画最终状态回到原来的状态
    animationY.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    _animationY = animationY;
    
    return animationY;
}


@end
