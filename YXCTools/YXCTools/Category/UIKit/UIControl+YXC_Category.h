//
//  UIControl+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIControl (YXC_Category)

@property (nonatomic, assign) CGFloat yxc_eventInterval; /**< 按钮防止重复点击 */
@property (nonatomic, assign) CGFloat yxc_expandSize; /**< 需要扩大的范围大小 */
@property (nonatomic, assign) CGFloat yxc_horizontalSize; /**< 横向扩大范围大小 */
@property (nonatomic, assign) CGFloat yxc_verticalSize; /**< 垂直扩大范围大小 */

@end

