//
//  UITextField+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITextFieldTextMaxLengthDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (YXC_Category)

@property (nonatomic, weak) id<UITextFieldTextMaxLengthDelegate> yxc_delegate; /**< 代理 */
@property (nonatomic, assign) NSInteger textMaxLength; /**< 文本最大字数限制 */
@property (nonatomic, assign) BOOL yxc_usingSystemKeyboard;  /**< 使用系统键盘 */
/**
 * 在 AppDelegate 中实现
 *
 * - (BOOL)application:(UIApplication *)application shouldAllowExtensionPointIdentifier:(UIApplicationExtensionPointIdentifier)extensionPointIdentifier {
 *
 *  if ([extensionPointIdentifier isEqualToString:@"com.apple.keyboard-service"]) {
 *       if (UITextField.yxc_globalUsingSystemKeyboard) {
 *         return NO;
 *       }
 *    }
 *    return YES;
 * }
 */
@property (nonatomic, assign, class) BOOL yxc_globalUsingSystemKeyboard;   /**< 全局是否使用系统键盘，主动设置无效 */

@end


#pragma mark - ================ UITextFieldTextMaxLengthDelegate ================

@protocol UITextFieldTextMaxLengthDelegate <NSObject>

@optional

/// UITextField 文本发生改变代理方法
/// @param textField UITextField输入框
/// @param text 当前文本字符串
/// @param textLength 当前文本字符串长度
/// @param textMaxLength 当前输入框限制最大字符长度
- (void)textField:(UITextField *)textField
    textDidChange:(NSString *)text
       textLength:(NSInteger)textLength
    textMaxLength:(NSInteger)textMaxLength;

@end



NS_ASSUME_NONNULL_END
