//
//  YXCScanView.h
//  YXCTools
//
//  Created by guogt on 2022/5/13.
//  Copyright © 2022 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 扫描二维码界面
@interface YXCScanView : UIView

#pragma mark - Property


#pragma mark - Method

/// 开始动画
- (void)startAnimation;

/// 暂停动画
- (void)pauseAnimation;

/// 结束动画
- (void)stopAnimation;

/// 添加返回事件
- (void)addBackAction:(_Nonnull SEL)action target:(_Nonnull id)target;

/// 添加前往相册事件
- (void)addPhotoButtonAction:(_Nonnull SEL)action target:(_Nonnull id)target;

@end

NS_ASSUME_NONNULL_END
