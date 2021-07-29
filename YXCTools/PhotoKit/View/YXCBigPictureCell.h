//
//  YXCBigPictureCell.h
//  YXCTools
//
//  Created by GGT on 2021/7/29.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXCAssetModel;

UIKIT_EXTERN NSString *const YXCBigPictureCellIdentifier;

@interface YXCBigPictureCell : UICollectionViewCell

#pragma mark - Property

@property (nonatomic, strong) YXCAssetModel *assetModel;


#pragma mark - Method

@end
