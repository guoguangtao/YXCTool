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

@property (nonatomic, strong) YXCAssetModel *model;


#pragma mark - Method

+ (instancetype)showWithAssetModel:(YXCAssetModel *)model;

- (void)dismiss;

@end
