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
    [self changeFrame];
}


#pragma mark - IBActions


#pragma mark - Public


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
    
    [UIView beginAnimations:@"FrameAni" context:nil];
    [UIView setAnimationDuration:5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationWillStartSelector:@selector(startAni:)];
    [UIView setAnimationDidStopSelector:@selector(stopAni:)];
    [UIView setAnimationRepeatCount:1];
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
