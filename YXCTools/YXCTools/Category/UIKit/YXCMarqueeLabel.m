//
//  YXCMarqueeLabel.m
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCMarqueeLabel.h"
#import "UIView+YXC_Category.h"

@interface YXCMarqueeLabel ()

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UILabel *firstLabel; /**< 第一个 Label */
@property (nonatomic, strong) UILabel *secondLabel; /**< 第二个 Label */

@end

@implementation YXCMarqueeLabel

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置 UILabel 的 centerY
    self.firstLabel.centerY = self.height * 0.5f;
    self.secondLabel.centerY = self.height * 0.5f;
    
    // 设置 contentView 的 高度
    self.contentView.height = self.height;
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        self.duration = 5;
        self.spacingBetweenLabels = 20;
        self.autoBeginScroll = YES;
        self.beginDelay = 0;
        self.pauseDelay = 0;
        self.fontSize = 14.0f;
        self.textColor = UIColor.whiteColor;
        
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
    
    // 设置 Label 文本
    self.firstLabel.text = text;
    self.secondLabel.text = text;
    
    // 设置 Label 的 frame
    [self.firstLabel sizeToFit];
    [self.secondLabel sizeToFit];
    self.firstLabel.x = 0;
    self.secondLabel.x = self.firstLabel.width + self.spacingBetweenLabels;
    
    // 设置 contentView 的 frame
    self.contentView.x = 0;
    self.contentView.y = 0;
    
    if (self.autoBeginScroll) {
        YXCWeakSelf(self);
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.beginDelay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakself contentViewAnimations];
        });
    }
}

- (void)setTextColor:(UIColor *)textColor {
    
    _textColor = textColor;
    
    // 设置 Label 的文本颜色
    self.firstLabel.textColor = self.textColor;
    self.secondLabel.textColor = self.textColor;
}

- (void)setFontSize:(CGFloat)fontSize {
    
    _fontSize = fontSize;
    
    // 设置 Label 的字体大小
    self.firstLabel.font = [UIFont systemFontOfSize:self.fontSize];
    self.secondLabel.font = [UIFont systemFontOfSize:self.fontSize];
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)contentViewAnimations {
    
    // 设置 contentView
    self.contentView.width = self.firstLabel.width + self.spacingBetweenLabels;
    
    if (self.scrollVelocity > 0) {
        // 如果有设置速度，则根据速度计算动画时长
        self.duration = self.firstLabel.width / self.scrollVelocity;
    }
    
    // 设置动画样式
    UIViewAnimationOptions options = UIViewAnimationOptionCurveLinear;
    
    // 如果有设置间隔时间，不设置无限循环模式
    if (self.pauseDelay <= 0) {
        options |= UIViewAnimationOptionRepeat;
    }
    
    YXCWeakSelf(self);
    [UIView animateWithDuration:self.duration
                          delay:0
                        options:options
                     animations:^{
        YXCLog(@"动画 ing");
        weakself.scrolling = YES;
        weakself.contentView.x = -(weakself.contentView.width);
    } completion:^(BOOL finished) {
        YXCLog(@"动画完成");
        weakself.scrolling = NO;
        weakself.contentView.x = 0;
        if (weakself.pauseDelay > 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(weakself.pauseDelay * NSEC_PER_SEC)),
                           dispatch_get_main_queue(), ^{
                [weakself contentViewAnimations];
            });
        }
    }];
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    // contentView
    self.contentView = [UIView new];
    [self addSubview:self.contentView];
    
    // firstLabel
    self.firstLabel = [self setupLabel];
    
    // secondLabel
    self.secondLabel = [self setupLabel];
}

- (UILabel *)setupLabel {
    
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:self.fontSize];
    label.textColor = self.textColor;
    [self.contentView addSubview:label];
    
    return label;
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
