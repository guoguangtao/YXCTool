//
//  YXCBannerCell.h
//  YXCTools
//
//  Created by lbkj on 2021/9/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCBannerCell : UICollectionViewCell

#pragma mark - Property

@property (nonatomic, copy) NSString *text;


#pragma mark - Method

/// 动画
- (void)yxc_animationWithScrollView:(UIScrollView *)scrollView layout:(UICollectionViewFlowLayout *)layout;


@end

NS_ASSUME_NONNULL_END
