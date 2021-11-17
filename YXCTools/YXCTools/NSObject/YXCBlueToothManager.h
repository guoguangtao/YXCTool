//
//  YXCBlueToothManager.h
//  YXCTools
//
//  Created by lbkj on 2021/11/12.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@protocol YXCBlueToothManagerDelegate <NSObject>

@optional

/// 发现设备
- (void)yxc_blueToothManager:(CBCentralManager *_Nonnull)central didDiscoverPeripheral:(CBPeripheral *_Nonnull)peripheral advertisementData:(NSDictionary<NSString *, id> *_Nullable)advertisementData RSSI:(NSNumber *_Nullable)RSSI;

/// 蓝牙设备连接成功
- (void)yxc_blueToothManager:(CBCentralManager *_Nonnull)central didConnectPeripheral:(CBPeripheral *_Nonnull)peripheral;

/// 蓝牙设备连接失败
- (void)yxc_blueToothManager:(CBCentralManager *_Nonnull)central didFailToConnectPeripheral:(CBPeripheral *_Nonnull)peripheral error:(NSError *_Nullable)error;

@end

NS_ASSUME_NONNULL_BEGIN

@interface YXCBlueToothManager : NSObject

#pragma mark - Property

@property (nonatomic, weak) UIViewController *owner; /**< 拥有者 */
@property (nonatomic, weak) id <YXCBlueToothManagerDelegate> delegate;


#pragma mark - Method

+ (instancetype)shareInstance;

/// 开始搜索蓝牙设备
- (void)startScan;

/// 停止扫描蓝牙设备
- (void)stopScan;

/// 连接蓝牙设备
/// @param peripheral 需要连接的蓝牙设备
/// @param options 可选字典，用于指定连接行为选项
- (void)connectPeripheral:(CBPeripheral *)peripheral
                  options:(NSDictionary<NSString *,id> *)options;

@end

NS_ASSUME_NONNULL_END
