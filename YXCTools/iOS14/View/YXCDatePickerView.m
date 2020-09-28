//
//  YXCDatePickerView.m
//  YXCTools
//
//  Created by GGT on 2020/9/19.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCDatePickerView.h"

@interface YXCDatePickerView ()

@end

@implementation YXCDatePickerView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5f];
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self removeFromSuperview];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    CGRect frame = CGRectMake(0, 200, self.width, 100);
    UIDatePicker *datePicer = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    if (@available(iOS 13.4, *)) {
        datePicer.preferredDatePickerStyle = UIDatePickerStyleWheels; // 只设置了 preferredDatePickerStyle 属性
    }
    datePicer.backgroundColor = [UIColor whiteColor];
    datePicer.frame = frame;
    [self addSubview:datePicer];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
