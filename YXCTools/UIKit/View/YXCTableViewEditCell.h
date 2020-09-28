//
//  YXCTableViewEditCell.h
//  YXCTools
//
//  Created by GGT on 2020/9/28.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <UIKit/UIKit.h>

/// tableView 编辑 Cell
@interface YXCTableViewEditCell : UITableViewCell

#pragma mark - Property


#pragma mark - Method

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath;

@end
