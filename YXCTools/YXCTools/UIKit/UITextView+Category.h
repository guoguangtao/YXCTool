//
//  UITextView+Category.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UITextViewTextMaxLengthDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (Category)

@property (nonatomic, weak) id<UITextViewTextMaxLengthDelegate> yxc_delegate; /**< 代理 */
@property (nonatomic, assign) NSInteger textMaxLength; /**< 文本最大字数限制 默认为0，代表无限制输入*/
@property (nonatomic, copy) NSString *yxc_placeHolder; /**< 占位文字，如果textView还有初始值，请在设置 yxc_delegate, textMaxLength 属性之前，设置 yxc_placeHolder 和 text 属性  */


@end

#pragma mark - ================ UITextViewTextMaxLengthDelegate ================

@protocol UITextViewTextMaxLengthDelegate <NSObject>

@optional

/// TextView 文本发生改变代理方法
/// @param textView TextView输入框
/// @param text 当前文本字符串
/// @param textLength 当前文本字符串长度
/// @param textMaxLength 当前输入框限制最大字符长度
- (void)textView:(UITextView *)textView
   textDidChange:(NSString *)text
      textLength:(NSInteger)textLength
   textMaxLength:(NSInteger)textMaxLength;

@end

NS_ASSUME_NONNULL_END
