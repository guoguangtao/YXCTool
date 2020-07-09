//
//  UITextView+Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UITextView+Category.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel; /**< 占位文字 */

@end

@implementation UITextView (Category)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);

    
    Method system_init_method = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method my_init_method = class_getInstanceMethod([self class], @selector(yxc_initWithFrame:));
    method_exchangeImplementations(system_init_method, my_init_method);
}

- (void)deallocSwizzle {
    
    NSLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self deallocSwizzle];
}

- (instancetype)yxc_initWithFrame:(CGRect)frame {
    
    self.textMaxLength = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    
    return [self yxc_initWithFrame:frame];
}

- (void)setTextMaxLength:(NSInteger)textMaxLength {
    
    NSNumber *number = [NSNumber numberWithInteger:textMaxLength];
    objc_setAssociatedObject(self, @selector(textMaxLength), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    if (textMaxLength > 0) {
        [self performDelegate];
    }
}

- (NSInteger)textMaxLength {
    
    return [objc_getAssociatedObject(self, @selector(textMaxLength)) integerValue];
}

- (void)setYxc_delegate:(id<UITextViewTextMaxLengthDelegate>)yxc_delegate {
    
    objc_setAssociatedObject(self, @selector(yxc_delegate), yxc_delegate, OBJC_ASSOCIATION_ASSIGN);
    if (self.textMaxLength > 0) {
        [self performDelegate];
    }
}

- (id<UITextViewTextMaxLengthDelegate>)yxc_delegate {
    
    return objc_getAssociatedObject(self, @selector(yxc_delegate));
}

- (void)setYxc_placeHolder:(NSString *)yxc_placeHolder {
    
    if (yxc_placeHolder &&
        [yxc_placeHolder isKindOfClass:[NSString class]] &&
        yxc_placeHolder.length) {
        objc_setAssociatedObject(self, @selector(yxc_placeHolder), yxc_placeHolder, OBJC_ASSOCIATION_COPY);
        
        // 创建占位文字
        if (self.placeHolderLabel == nil) {
            self.placeHolderLabel = [UILabel new];
            self.placeHolderLabel.textColor = [UIColor grayColor];
            self.placeHolderLabel.font = self.font;
            [self addSubview:self.placeHolderLabel];
        }
        
        if (self.placeHolderLabel) {
            self.placeHolderLabel.text = yxc_placeHolder;
            CGSize size = [self.placeHolderLabel sizeThatFits:CGSizeMake(MAXFLOAT, MAXFLOAT)];
            UIEdgeInsets insets = self.textContainerInset;
            self.placeHolderLabel.frame = CGRectMake(insets.left + 2, insets.top, size.width, size.height);
        }
    }
}

- (NSString *)yxc_placeHolder {
    
    return objc_getAssociatedObject(self, @selector(yxc_placeHolder));
}

- (void)setPlaceHolderLabel:(UILabel *)placeHolderLabel {
    
    objc_setAssociatedObject(self, @selector(placeHolderLabel), placeHolderLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UILabel *)placeHolderLabel {
    
    return objc_getAssociatedObject(self, @selector(placeHolderLabel));
}


- (void)textViewTextDidChange {
    
    if (self.placeHolderLabel) {
        self.placeHolderLabel.hidden = self.text.length;
    }
    
    if (self.textMaxLength <= 0) return;
    
    NSString *toBeString = self.text;

    // 获取键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;

    if ([lang isEqualToString:@"zh-Hans"] ||
        [lang isEqualToString:@"zh-Hant"] ||
        [lang isEqualToString:@"zh-TW"]) {
        
        UITextRange *selectedRange = [self markedTextRange];
        // 获取高亮部分
        UITextPosition *position = [self positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > self.textMaxLength) {
                // 超出限制则截取最大限制的文本
                self.text = [toBeString substringToIndex:self.textMaxLength];
            }
            [self performDelegate];
        }
    } else {
        // 中文输入法以外的直接统计
        if (toBeString.length > self.textMaxLength) {
            self.text = [toBeString substringToIndex:self.textMaxLength];
        }
        [self performDelegate];
    }
}

- (void)performDelegate {
    
    if (self.placeHolderLabel) {
        self.placeHolderLabel.hidden = self.text.length;
    }
    
    if ([self.yxc_delegate respondsToSelector:@selector(textView:textDidChange:textLength:textMaxLength:)]) {
        [self.yxc_delegate textView:self
                      textDidChange:self.text
                         textLength:self.text.length
                      textMaxLength:self.textMaxLength];
    }
}

@end
