//
//  YXCBlueToothDeviceCell.h
//  YXCTools
//
//  Created by lbkj on 2021/11/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CBPeripheral;

NS_ASSUME_NONNULL_BEGIN

@interface YXCBlueToothDeviceCell : UITableViewCell

#pragma mark - Property

@property (nonatomic, strong) CBPeripheral *peripheral;


#pragma mark - Method

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;


@end

NS_ASSUME_NONNULL_END
