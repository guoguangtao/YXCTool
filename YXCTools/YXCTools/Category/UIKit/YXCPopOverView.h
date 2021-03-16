//
//  YXCPopOverView.h
//  YXCTools
//
//  Created by GGT on 2020/10/23.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXCPopOverView : UIView

#pragma mark - Property

@property (nonatomic, strong) UIColor *yxc_backgroundColor; /**< 背景颜色 */
@property (nonatomic, assign) CGFloat triangleWidth; /**< 三角形宽度 */
@property (nonatomic, assign) CGFloat triangleHeight; /**< 三角形高度 */


#pragma mark - Method

/// 从 view 展示弹窗
/// @param view 被点击的 view
- (void)showFrom:(UIView *)view;

@end
