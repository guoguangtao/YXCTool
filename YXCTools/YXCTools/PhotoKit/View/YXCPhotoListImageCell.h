//
//  YXCPhotoListImageCell.h
//  YXCTools
//
//  Created by GGT on 2020/9/25.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXCAssetModel;

@protocol YXCPhotoListImageCellDelegate;


#define kPhotoListImageCellIdentifier @"YXCPhotoListImageCellIdentifier"

@interface YXCPhotoListImageCell : UICollectionViewCell

#pragma mark - Property

@property (nonatomic, copy) NSString *selectedTitle; /**< 选中照片索引 */
@property (nonatomic, weak) id<YXCPhotoListImageCellDelegate> delegate; /**< 代理 */
@property (nonatomic, strong) YXCAssetModel *assetModel;


#pragma mark - Method

@end


#pragma mark - ================ YXCPhotoListImageCellDelegate ================

@protocol YXCPhotoListImageCellDelegate <NSObject>

@optional

- (void)listImageCell:(YXCPhotoListImageCell *)cell didSelectedWithAssetModel:(YXCAssetModel *)assetModel;

@end
