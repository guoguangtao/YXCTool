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

/// 设置背景颜色
/// @param color 颜色
/// @param state 状态
- (void)setBackgroundColor:(UIColor *)color forState:(UIControlState)state;

///  设置图片
/// @param imageName 图片名称
/// @param state 状态
- (void)yxc_setImage:(NSString *)imageName forState:(UIControlState)state;

@end

NS_ASSUME_NONNULL_END
