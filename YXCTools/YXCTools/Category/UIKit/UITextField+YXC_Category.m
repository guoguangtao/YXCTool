//
//  UITextField+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "UITextField+YXC_Category.h"
#import "NSObject+YXC_Category.h"
#import <objc/runtime.h>

@implementation UITextField (YXC_Category)

+ (void)load {
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:NSSelectorFromString(@"dealloc")
                          currentSelector:@selector(yxc_textField_deallocSwizzle)];

    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(initWithFrame:)
                          currentSelector:@selector(yxc_textField_initWithFrame:)];
}

- (void)yxc_textField_deallocSwizzle {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self yxc_textField_deallocSwizzle];
}

- (instancetype)yxc_textField_initWithFrame:(CGRect)frame {
    
    self.textMaxLength = 0;
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldTextDidChange)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidBeginEdit:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textFieldDidEndEdit:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:self];
    
    return [self yxc_textField_initWithFrame:frame];
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

- (void)setYxc_usingSystemKeyboard:(BOOL)yxc_usingSystemKeyboard {
    
    objc_setAssociatedObject(self, @selector(yxc_usingSystemKeyboard), @(yxc_usingSystemKeyboard), OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)yxc_usingSystemKeyboard {
    
    NSNumber *yxc_usingSystemKeyboard = objc_getAssociatedObject(self, @selector(yxc_usingSystemKeyboard));
    return [yxc_usingSystemKeyboard boolValue];
}

+ (void)setYxc_globalUsingSystemKeyboard:(BOOL)yxc_globalUsingSystemKeyboard {
    
    objc_setAssociatedObject(self, @selector(yxc_globalUsingSystemKeyboard), @(yxc_globalUsingSystemKeyboard), OBJC_ASSOCIATION_ASSIGN);
}

+ (BOOL)yxc_globalUsingSystemKeyboard {
    
    NSNumber *yxc_globalUsingSystemKeyboard = objc_getAssociatedObject(self, @selector(yxc_globalUsingSystemKeyboard));
    return [yxc_globalUsingSystemKeyboard boolValue];
}

- (void)textFieldTextDidChange {
    
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

- (void)textFieldDidBeginEdit:(NSNotification *)notification {
    
    UITextField.yxc_globalUsingSystemKeyboard = self.yxc_usingSystemKeyboard;
}

- (void)textFieldDidEndEdit:(NSNotification *)notification {
    
    UITextField.yxc_globalUsingSystemKeyboard = NO;
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
