//
//  YXCBlueToothDeviceCell.m
//  YXCTools
//
//  Created by lbkj on 2021/11/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBlueToothDeviceCell.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface YXCBlueToothDeviceCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

@implementation YXCBlueToothDeviceCell

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"YXCBlueToothDeviceCell";
    YXCBlueToothDeviceCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[YXCBlueToothDeviceCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.indexPath = indexPath;
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (void)setPeripheral:(CBPeripheral *)peripheral {
    _peripheral = peripheral;
    self.textLabel.text = peripheral.name;
    self.detailTextLabel.text = peripheral.identifier.UUIDString;
}


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


#pragma mark - Lazy

@end
