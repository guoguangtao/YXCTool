//
//  YXCMarqueeLabel.h
//  YXCTools
//
//  Created by GGT on 2020/10/26.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 跑马灯 Label
@interface YXCMarqueeLabel : UIView

#pragma mark - Property

@property (nonatomic, assign) CGFloat scrollVelocity; /**< 滚动速度,必须大于 0 否则无效,设置该属性, duration 属性失效 */
@property (nonatomic, assign) NSTimeInterval duration; /**< 动画时长,默认 5s */
@property (nonatomic, assign) NSTimeInterval beginDelay; /**< 第一次动画延长时间，只有当 autoBeginScroll 为 YES 有效，默认为 0 */
@property (nonatomic, assign) NSTimeInterval pauseDelay; /**< 暂时间隔时间，默认为 0 */
@property (nonatomic, assign) CGFloat spacingBetweenLabels; /**< label 之间的间距，默认 20 */
@property (nonatomic, assign) BOOL autoBeginScroll; /**< 自动开始滚动 默认 YES */
@property (nonatomic, assign, getter=isScrolling) BOOL scrolling; /**< 是否正在滚动 */
@property (nonatomic, strong) UIColor *textColor;  /**< 文本颜色 */
@property (nonatomic, assign) CGFloat fontSize;  /**< 字体大小 */
@property (nonatomic, copy) NSString *text; /**< 文本，设置了文本之后开始滚动，所以在设置文本之前，请先把其他的属性设置好 */


#pragma mark - Method


@end
