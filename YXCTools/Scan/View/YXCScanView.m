//
//  YXCScanView.m
//  YXCTools
//
//  Created by guogt on 2022/5/13.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCScanView.h"

#define scaleY ([[UIScreen mainScreen] bounds].size.height / 667.0)

@interface YXCScanView ()

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *photoButton;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, assign, getter=isLineUp) BOOL lineUp; /**< 横线是否向上动画 */
@property (nonatomic, strong) NSTimer *timer; /**< 动画定时器 */

@end


@implementation YXCScanView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {

}

- (instancetype)initWithFrame:(CGRect)frame {

    if (self = [super initWithFrame:frame]) {

        self.lineUp = NO;
        [self setupUI];
        [self setupConstraints];
    }

    return self;
}

- (void)dealloc {

    YXCDebugLogMethod();
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public

/// 开始动画
- (void)startAnimation {

    [self p_startTimer];
}

/// 暂停动画
- (void)pauseAnimation {

    [self stopAnimation];
}

/// 结束动画
- (void)stopAnimation {

    self.lineImageView.hidden = YES;
    [self p_stopTimer];
}

- (void)addBackAction:(SEL)action target:(id)target {

    if (action && target) {
        [self.backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)addPhotoButtonAction:(SEL)action target:(id)target {

    if (action && target) {
        [self.photoButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
}


#pragma mark - Private

- (void)p_startTimer {

    [self p_stopTimer];

    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(p_changeLineImageViewY) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)p_stopTimer {

    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/// 横线上下动画
- (void)p_changeLineImageViewY {

    self.lineImageView.hidden = NO;
    CGPoint center = self.lineImageView.center;
    if (self.isLineUp) {
        // 向上移动
        center.y -= 2;
        if (center.y <= 110 * scaleY) {
            self.lineUp = false;
        }
    } else {
        // 向下移动
        center.y += 2;
        if (center.y >= 385.5 * scaleY) {
//            self.lineUp = true;
            center.y = 110 * scaleY;
        }
    }
    self.lineImageView.center = center;
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {

    self.backgroundColor = UIColor.clearColor;

    self.backButton = [UIButton new];
    [self.backButton setImage:[UIImage imageNamed:@"navigation_back_white"] forState:UIControlStateNormal];
    [self addSubview:self.backButton];

    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:18 weight:UIFontWeightMedium];
    self.titleLabel.text = @"连接设备";
    self.titleLabel.textColor = UIColor.whiteColor;
    [self addSubview:self.titleLabel];

    self.photoButton = [UIButton new];
    [self.photoButton setImage:[UIImage imageNamed:@"scan_photo_btn"] forState:UIControlStateNormal];
    self.photoButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    self.photoButton.layer.cornerRadius = 24;
    self.photoButton.layer.masksToBounds = YES;
    [self addSubview:self.photoButton];

    self.descLabel = [UILabel new];
    self.descLabel.font = [UIFont systemFontOfSize:16];
    self.descLabel.textColor = UIColor.whiteColor;
    self.descLabel.text = @"请扫描「投屏二维码」";
    [self addSubview:self.descLabel];

    self.lineImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_line_image"]];
    self.lineImageView.frame = CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), 75);
    self.lineImageView.center = CGPointMake(CGRectGetMidX(UIScreen.mainScreen.bounds), 193 * scaleY);
    self.lineImageView.hidden = YES;
    [self addSubview:self.lineImageView];
}


#pragma mark - Constraints

- (void)setupConstraints {

    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(kStatusBarHeight);
        make.height.mas_equalTo(kNavigationBarHeight);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.backButton);
        make.centerX.equalTo(self);
    }];

    [self.photoButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.width.height.mas_equalTo(48);
        make.bottom.equalTo(self).offset(-(110 + kBottomBarHeight));
    }];

    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.photoButton);
    }];
}


#pragma mark - Lazy

@end
