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

@property (nonatomic, copy) NSString *text; /**< 文本 */
@property (nonatomic, assign) CGFloat scrollVelocity; /**< 滚动速度,必须大于 0 否则无效,设置该属性, duration 属性失效 */
@property (nonatomic, assign) NSTimeInterval duration; /**< 动画时长,默认 10s */
@property (nonatomic, assign) NSTimeInterval beginDelay; /**< 首次动画执行延长时间,默认3s */
@property (nonatomic, assign) NSTimeInterval pauseDelay; /**< 动画完成一次时,紧接着下次动画的暂停时间,默认 0 */
@property (nonatomic, assign) BOOL autoScroll; /**< 是否需要自动执行动画,默认 YES */
@property (nonatomic, assign, getter=isAnimating) BOOL animating; /**< 动画是否在执行中 */


#pragma mark - Method

- (void)beginAnimation;

- (void)stopAnimation;

@end
