//
//  UIView+Category.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// View 边框枚举
typedef NS_OPTIONS(NSUInteger, YXCViewBorder) {
    YXCViewBorderNone   = 0,
    YXCViewBorderTop    = 1 << 0,
    YXCViewBorderLeft   = 1 << 1,
    YXCViewBorderBottom = 1 << 2,
    YXCViewBorderRight  = 1 << 3,
    YXCViewBorderAll    = YXCViewBorderTop | YXCViewBorderLeft | YXCViewBorderBottom | YXCViewBorderRight
};

@interface UIView (Category)

#pragma mark - Property

@property (nonatomic, assign) CGFloat x;         /**< UIView X 坐标值 */
@property (nonatomic, assign) CGFloat y;         /**< UIView Y 坐标值 */
@property (nonatomic, assign) CGFloat width;     /**< UIView Width 坐标值 */
@property (nonatomic, assign) CGFloat height;    /**< UIView Heignth 坐标值 */
@property (nonatomic, assign) CGSize size;       /**< UIView Size 坐标值 */
@property (nonatomic, assign) CGPoint origin;    /**< UIView Origin 坐标值 */
@property (nonatomic, assign) CGFloat centerX;   /**< UIView Center X坐标值 */
@property (nonatomic, assign) CGFloat centerY;   /**< UIView Center Y坐标值 */
@property (nonatomic, assign) YXCViewBorder yxc_border; /**< UIView 边框 */
@property (nonatomic, assign) CGFloat yxc_borderWidth; /**< UIView 边框宽度 */
@property (nonatomic, strong) UIColor *yxc_borderColor; /**< UIView 边框颜色 */


#pragma mark - Method

/// 移除所有子视图
- (void)yxc_removeAllSubView;

@end

NS_ASSUME_NONNULL_END
