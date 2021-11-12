//
//  YXCTableViewEditCell.m
//  YXCTools
//
//  Created by GGT on 2020/9/28.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCTableViewEditCell.h"

@interface YXCTableViewEditCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YXCTableViewEditCell

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"YXCTableViewEditCell";
    YXCTableViewEditCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[YXCTableViewEditCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    cell.indexPath = indexPath;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
//        UIBackgroundConfiguration *configuration = [UIBackgroundConfiguration clearConfiguration];
//        self.backgroundConfiguration = configuration;
        
        self.multipleSelectionBackgroundView = [UIView new];
        self.multipleSelectionBackgroundView.backgroundColor = [UIColor redColor];
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}




#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setIndexPath:(NSIndexPath *)indexPath {
    
    _indexPath = indexPath;
    
    self.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    
    UIColor *color = UIColor.whiteColor;

    self.contentView.backgroundColor = color; // 内容显示部分设置颜色
    self.backgroundColor = color; // 左边选中部分设置颜色
}

//- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
//    [super setSelected:selected animated:animated];
//
//    self.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
//}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    

}


#pragma mark - 懒加载

@end
