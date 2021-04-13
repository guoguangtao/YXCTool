//
//  UIButton+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, YXCButtomImage) {
    YXCButtomImageLeft = 0, /**< 图片居左 */
    YXCButtomImageBottom,   /**< 图片居下 */
    YXCButtomImageRight,    /**< 图片居右 */
    YXCButtomImageTop,      /**< 图片居上 */
};

@interface UIButton (YXC_Category)

@property (nonatomic, assign) CGFloat yxc_imageTitleSpace;          /**< 图片文字间距 */
@property (nonatomic, assign) YXCButtomImage yxc_imagePosition;     /**< 图片位置枚举 */
@property (nonatomic, assign, readonly) CGSize yxc_buttonSize;      /**< 最终按钮的最适合 size */

/// 设置背景颜色
/// @param color 颜色
/// @param state 状态
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

///  设置图片
/// @param imageName 图片名称
/// @param state 状态
- (void)yxc_setImage:(NSString *)imageName forState:(UIControlState)state;

/// 更新 size
- (void)yxc_sizeToFit;


#pragma mark - 链式编程函数

/// 设置标题
- (UIButton *(^)(NSString *title, UIControlState state))yxc_setTitle;

/// 设置背景颜色
- (UIButton *(^)(UIColor *color, UIControlState state))yxc_setBackgroundColor;

/// 设置文字颜色
- (UIButton *(^)(UIColor *color, UIControlState state))yxc_setTitleColor;

/// 设置图片
- (UIButton *(^)(NSString *imageName, UIControlState state))yxc_setImageName;

/// 设置图片
- (UIButton *(^)(UIImage *image, UIControlState state))yxc_setImage;

/// 设置背景图片
- (UIButton *(^)(UIImage *image, UIControlState state))yxc_setBackgroundImage;

/// 设置背景图片
- (UIButton *(^)(NSString *imageName, UIControlState state))yxc_setBackgroundImageName;

/// 设置图片的位置
- (UIButton *(^)(YXCButtomImage imagePosition))yxc_setImagePosition;

/// 设置图片和文字之间的间距
- (UIButton *(^)(CGFloat imageTitleSpace))yxc_setImageTitleSpace;

/// 添加事件
- (UIButton *(^)(id target, SEL action, UIControlEvents controlEvents))yxc_addAction;

/// 设置系统字体大小
- (UIButton *(^)(UIFont *font))yxc_setSystemFontOfSize;

/// 设置系统字体大小
- (UIButton *(^)(CGFloat fontSize, UIFontWeight weight))yxc_setFont;

/// 设置系统字体大小
- (UIButton *(^)(CGFloat fontSize))yxc_setFontSize;

/// 添加到父视图
- (UIButton *(^)(UIView *superView))yxc_addForSuperView;

/// 设置 Tag
- (UIButton *(^)(NSInteger tag))yxc_setTag;

/// 设置圆角
- (UIButton *(^)(CGFloat cornerRadius))yxc_setCornerRadius;

/// 设置边框
- (UIButton *(^)(UIColor *borderColor, CGFloat borderWidth))yxc_setBorder;

/// 设置 Frame
- (UIButton *(^)(CGFloat x, CGFloat y, CGFloat width, CGFloat height))yxc_setFrame;

/// 设置 size
- (UIButton *(^)(CGFloat width, CGFloat height))yxc_setSize;

/// 设置 center
- (UIButton *(^)(CGFloat centerX, CGFloat centerY))yxc_setCenter;

/// 通过 CGPoint 设置 center
- (UIButton *(^)(CGPoint center))yxc_setCenterByPoint;

@end

NS_ASSUME_NONNULL_END
