//
//  UITextView+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UITextView+YXC_Category.h"
#import "NSObject+YXC_Category.h"
#import <objc/runtime.h>

@interface UITextView ()

@property (nonatomic, strong) UILabel *placeHolderLabel; /**< 占位文字 */

@end

@implementation UITextView (YXC_Category)

+ (void)load {
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:NSSelectorFromString(@"dealloc")
                          currentSelector:@selector(yxc_textView_deallocSwizzle)];

    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(initWithFrame:)
                          currentSelector:@selector(yxc_textView_initWithFrame:)];
}

- (void)yxc_textView_deallocSwizzle {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self yxc_textView_deallocSwizzle];
}

- (instancetype)yxc_textView_initWithFrame:(CGRect)frame {
    
    self.textMaxLength = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textViewTextDidChange)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
    
    return [self yxc_textView_initWithFrame:frame];
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

    UITextRange *selectedRange = [self markedTextRange];
    if (selectedRange && !selectedRange.isEmpty) {
        return;
    }
    if (toBeString.length > self.textMaxLength) {
        self.text = [toBeString substringToIndex:self.textMaxLength];
    }
    [self performDelegate];
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
