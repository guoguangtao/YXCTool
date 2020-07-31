//
//  YXCButton.h
//  YXCTools
//
//  Created by GGT on 2020/7/30.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, YXCButtonImagePosition) {
    YXCButtonImagePositionLeft = 0,
    YXCButtonImagePositionTop,
    YXCButtonImagePositionRight,
    YXCButtonImagePositionBottom,
};

@interface YXCButton : UIButton

#pragma mark - Property

@property (nonatomic, assign) CGFloat yxc_space; /**< 图片和文字的间隙 */
@property (nonatomic, assign) YXCButtonImagePosition yxc_imagePosition; /**< 图片的位置 */


#pragma mark - Method

@end
