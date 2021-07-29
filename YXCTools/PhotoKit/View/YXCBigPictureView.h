//
//  YXCBigPictureView.h
//  YXCTools
//
//  Created by GGT on 2020/10/9.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXCAssetModel;

@interface YXCBigPictureView : UIView

#pragma mark - Property

@property (nonatomic, strong) NSArray<YXCAssetModel *> *photos;  /**< 图片 */
@property (nonatomic, assign) NSInteger selectedIndex;


#pragma mark - Method

/// 展示图片
/// @param photos 图片数组
+ (instancetype)showWithAssetModels:(NSArray<YXCAssetModel *> *)photos
                      selectedIndex:(NSInteger)selectedIndex;

- (void)dismiss;

@end
