//
//  YXCBlueToothManager.m
//  YXCTools
//
//  Created by lbkj on 2021/11/12.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBlueToothManager.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface YXCBlueToothManager ()<CBCentralManagerDelegate>

@property (nonatomic, strong) CBCentralManager *manager; /**< 蓝牙管理 */

@end

@implementation YXCBlueToothManager


#pragma mark - Lifecycle

static YXCBlueToothManager *_instance;

+ (instancetype)shareInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [[self alloc] init];
        }
    });
    
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (_instance == nil) {
            _instance = [super allocWithZone:zone];
        }
    });
    
    return _instance;
}

- (instancetype)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

- (void)startScan {
    if (self.manager.isScanning) return;
    
    NSDictionary *options = @{
        // 不重复扫描已发现设备
        CBCentralManagerScanOptionAllowDuplicatesKey : @(NO),
        // 如果蓝牙没有打开，弹出 Alert 提示
        CBPeripheralManagerOptionShowPowerAlertKey : @(YES),
    };
    [self.manager scanForPeripheralsWithServices:nil options:options];
}


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - CBCentralManagerDelegate

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    CBManagerState state = central.state;
    switch (state) {
        case CBManagerStateUnknown: {
            YXCLog(@"未知状态");
        }   break;
        case CBManagerStateResetting: {
            YXCLog(@"重启状态");
        }   break;
        case CBManagerStateUnsupported: {
            YXCLog(@"当前蓝牙不支持");
        }   break;
        case CBManagerStateUnauthorized: {
            YXCLog(@"未授权");
        }   break;
        case CBManagerStatePoweredOff: {
            YXCLog(@"蓝牙未开启");
        }   break;
        case CBManagerStatePoweredOn: {
            YXCLog(@"蓝牙已开启");
        }   break;
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    YXCDebugLogMethod();
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    YXCLog(@"peripheral.name:%@", peripheral.name);
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    YXCDebugLogMethod();
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    YXCDebugLogMethod();
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(nullable NSError *)error {
    YXCDebugLogMethod();
}

- (void)centralManager:(CBCentralManager *)central connectionEventDidOccur:(CBConnectionEvent)event forPeripheral:(CBPeripheral *)peripheral {
    YXCDebugLogMethod();
}

- (void)centralManager:(CBCentralManager *)central didUpdateANCSAuthorizationForPeripheral:(CBPeripheral *)peripheral  {
    YXCDebugLogMethod();
}


#pragma mark - Lazy

- (CBCentralManager *)manager {
    if (_manager) return _manager;
    NSDictionary *options = @{
        // 初始化 CBCentralManager 的时候，如果蓝牙没有打开，弹出 Alert 提示
        CBPeripheralManagerOptionShowPowerAlertKey : @(YES),
        // 唯一标识的字符串，用于蓝牙进程被杀掉恢复连接时用的
//        CBPeripheralManagerOptionRestoreIdentifierKey : @"YXCBlueToothIdentifier"
    };
    dispatch_queue_t centralQueue = dispatch_queue_create("centralQueue",DISPATCH_QUEUE_SERIAL);
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:options];
    return _manager;
}


@end
