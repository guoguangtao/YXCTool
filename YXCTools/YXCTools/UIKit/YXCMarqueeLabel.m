//
//  YXCMarqueeLabel.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCMarqueeLabel.h"

@interface YXCMarqueeLabel ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *firstLabel; /**< 第一个 Label */
@property (nonatomic, strong) UILabel *secondLabel; /**< 第二个 Label */
@property (nonatomic, assign) BOOL stopScroll; /**< 停止滚动 */

@end

@implementation YXCMarqueeLabel

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        self.duration = 3;
        self.beginDelay = 3;
        self.pauseDelay = 0;
        self.autoScroll = YES;
        self.animating = NO;
        self.stopScroll = NO;
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setText:(NSString *)text {
    
    _text = text;
    
    CGFloat gap = 20;
    
    self.firstLabel.text = text;
    self.secondLabel.text = text;
    [self.firstLabel sizeToFit];
    [self.secondLabel sizeToFit];
    self.firstLabel.x = 0;
    self.firstLabel.centerY = self.height * 0.5f;
    self.secondLabel.x = self.firstLabel.width + gap;
    self.secondLabel.centerY = self.height * 0.5f;
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.height = self.height;
    self.contentView.width = self.firstLabel.width + self.width + gap;
    
    self.secondLabel.hidden = self.firstLabel.width <= self.width;
    
    if (self.firstLabel.width > self.width) {
        YXCWeakSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.beginDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself changeFrame];
        });
    }
}

- (void)setScrollVelocity:(CGFloat)scrollVelocity {
    
    _scrollVelocity = scrollVelocity;
}


#pragma mark - IBActions


#pragma mark - Public

- (void)beginAnimation {
    
    [self changeFrame];
}

- (void)stopAnimation {
    
    self.animating = NO;
    self.stopScroll = YES;
    [self.contentView.layer removeAllAnimations];
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    // contentView
    self.contentView = [UIView new];
    [self addSubview:self.contentView];
    
    // firstLabel
    self.firstLabel = [UILabel new];
    [self.contentView addSubview:self.firstLabel];
    
    // secondLabel
    self.secondLabel = [UILabel new];
    [self.contentView addSubview:self.secondLabel];
}


- (void)changeFrame {
    
    if (self.scrollVelocity > 0) {
        self.duration = self.firstLabel.width / self.scrollVelocity;
    }
    
    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear;
    if (self.pauseDelay <= 0) {
        options |= UIViewAnimationOptionRepeat;
    }
    
    self.animating = YES;
    self.stopScroll = NO;
    [UIView animateWithDuration:self.duration
                          delay:self.pauseDelay
                        options:options
                     animations:^{
        self.contentView.x = -(self.firstLabel.width + 20);
    } completion:^(BOOL finished) {
        self.animating = NO;
        self.contentView.x = 0;
        if (self.pauseDelay > 0 && self.stopScroll == NO) {
            [self changeFrame];
        }
    }];
}

- (void)setupAnimations {
    
    // 此方式,在 iOS 13 开始已被放弃
    [UIView beginAnimations:@"FrameAni" context:nil];
    [UIView setAnimationDuration:self.duration];
    [UIView setAnimationDelegate:self];
//    [UIView setAnimationWillStartSelector:@selector(startAni:)];
//    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationRepeatCount:MAXFLOAT];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    self.contentView.x = -(self.firstLabel.width + 20);
    [UIView commitAnimations];
}

- (void)startAni:(NSString *)aniID {
    YXCLog(@"%@ start",aniID);
}

- (void)stopAni:(NSString *)aniID {
    self.contentView.x = 0;
    [self changeFrame];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
