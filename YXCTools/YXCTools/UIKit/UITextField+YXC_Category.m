//
//  UITextField+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UITextField+YXC_Category.h"
#import <objc/runtime.h>

@implementation UITextField (YXC_Category)

+ (void)load {
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method method2 = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(method1, method2);

    
    Method system_init_method = class_getInstanceMethod([self class], @selector(initWithFrame:));
    Method my_init_method = class_getInstanceMethod([self class], @selector(yxc_initWithFrame:));
    method_exchangeImplementations(system_init_method, my_init_method);
}

- (void)deallocSwizzle {
    
    YXCLog(@"%s", __func__);
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self deallocSwizzle];
}

- (instancetype)yxc_initWithFrame:(CGRect)frame {
    
    self.textMaxLength = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:nil];
    
    return [self yxc_initWithFrame:frame];
}

- (void)setTextMaxLength:(NSInteger)textMaxLength {
    
    NSNumber *number = [NSNumber numberWithInteger:textMaxLength];
    objc_setAssociatedObject(self, @selector(textMaxLength), number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.textMaxLength > 0) {
        [self performDelegate];
    }
}

- (NSInteger)textMaxLength {
    
    return [objc_getAssociatedObject(self, @selector(textMaxLength)) integerValue];
}

- (void)setYxc_delegate:(id<UITextFieldTextMaxLengthDelegate>)yxc_delegate {
    
    objc_setAssociatedObject(self, @selector(yxc_delegate), yxc_delegate, OBJC_ASSOCIATION_ASSIGN);
    if (self.textMaxLength > 0) {
        [self performDelegate];
    }
}

- (id<UITextFieldTextMaxLengthDelegate>)yxc_delegate {
    
    return objc_getAssociatedObject(self, @selector(yxc_delegate));
}

- (void)textFieldTextDidChange {
    
    if (self.textMaxLength <= 0) return;
    
    NSString *toBeString = self.text;

    // 获取键盘输入模式
    NSString *lang = [[UIApplication sharedApplication] textInputMode].primaryLanguage;

    if ([lang isEqualToString:@"zh-Hans"] ||
        [lang isEqualToString:@"zh-Hant"] ||
        [lang isEqualToString:@"zh-TW"]) {
        
        // 获取高亮部分
        UITextRange *selectedRange = [self markedTextRange];
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
    
    if ([self.yxc_delegate respondsToSelector:@selector(textField:textDidChange:textLength:textMaxLength:)]) {
        [self.yxc_delegate textField:self
                       textDidChange:self.text
                          textLength:self.text.length
                       textMaxLength:self.textMaxLength];
    }
}

@end
