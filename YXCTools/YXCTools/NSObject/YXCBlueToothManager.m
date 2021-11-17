//
//  YXCBlueToothManager.m
//  YXCTools
//
//  Created by lbkj on 2021/11/12.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBlueToothManager.h"

@interface YXCBlueToothManager ()<CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) CBCentralManager *manager; /**< 蓝牙管理 */

@end

@implementation YXCBlueToothManager {
    struct {
        unsigned int respondsToDidDiscoverPeripheral : 1;
        unsigned int respondsToDidConnectPeripheral : 1;
        unsigned int respondsToDidFailToConnectPeripheral : 1;
    } _delegateFlag;
}


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
        NSDictionary *options = @{
            // 初始化 CBCentralManager 的时候，如果蓝牙没有打开，弹出 Alert 提示
            CBPeripheralManagerOptionShowPowerAlertKey : @(YES),
            // 唯一标识的字符串，用于蓝牙进程被杀掉恢复连接时用的
    //        CBPeripheralManagerOptionRestoreIdentifierKey : @"YXCBlueToothIdentifier"
        };
        dispatch_queue_t centralQueue = dispatch_queue_create("centralQueue",DISPATCH_QUEUE_SERIAL);
        _manager = [[CBCentralManager alloc] initWithDelegate:self queue:centralQueue options:options];
    }
    return self;
}

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 方法)

- (void)setDelegate:(id<YXCBlueToothManagerDelegate>)delegate {
    _delegate = delegate;
    if ([delegate respondsToSelector:@selector(yxc_blueToothManager:didDiscoverPeripheral:advertisementData:RSSI:)]) {
        _delegateFlag.respondsToDidDiscoverPeripheral = YES;
    }
    if ([delegate respondsToSelector:@selector(yxc_blueToothManager:didConnectPeripheral:)]) {
        _delegateFlag.respondsToDidConnectPeripheral = YES;
    }
    if ([delegate respondsToSelector:@selector(yxc_blueToothManager:didFailToConnectPeripheral:error:)]) {
        _delegateFlag.respondsToDidFailToConnectPeripheral = YES;
    }
    
}


#pragma mark - Public

- (void)startScan {
    if (self.manager.isScanning) {
        YXCLog(@"正在扫描中");
        return;
    }
    
    // 蓝牙是否打开状态
    BOOL isOn = NO;
    switch (self.manager.state) {
        case CBManagerStatePoweredOn: {
            isOn = YES;
        }   break;
            
        default:
            break;
    }
    
    if (isOn) {
        YXCLog(@"开始扫描蓝牙");
        NSDictionary *options = @{
            // 不重复扫描已发现设备
            CBCentralManagerScanOptionAllowDuplicatesKey : @(NO),
            // 如果蓝牙没有打开，弹出 Alert 提示
            CBPeripheralManagerOptionShowPowerAlertKey : @(YES),
        };
        [self.manager scanForPeripheralsWithServices:nil options:options];
    }
}

/// 停止扫描蓝牙设备
- (void)stopScan {
    [self.manager stopScan];
}

/// 连接蓝牙设备
/// @param peripheral 需要连接的蓝牙设备
/// @param options 可选字典，用于指定连接行为选项
- (void)connectPeripheral:(CBPeripheral *)peripheral
                  options:(NSDictionary<NSString *,id> *)options {
    if (peripheral == nil) {
        YXCLog(@"要连接的蓝牙设备为空");
        return;
    }
    [self.manager connectPeripheral:peripheral options:options];
}


#pragma mark - Private

/// 蓝牙设备关闭操作
- (void)bluetoothPoweredOff {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentAlertControllerWithTitle:@"当前蓝牙状态已关闭，是否前往打开" cancelTitle:@"取消" confirmTitle:@"打开" cancelBlock:nil confirmBlock:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }];
    });
}

/// 该设备不支持蓝牙操作
- (void)bluetoothUnsupported {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentAlertControllerWithTitle:@"当前设备不支持蓝牙" cancelTitle:@"确定" confirmTitle:nil cancelBlock:nil confirmBlock:nil];
    });
}

/// 未授权操作
- (void)bluetoothUnauthorized {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self presentAlertControllerWithTitle:@"需要授权使用蓝牙，是否前往授权" cancelTitle:@"取消" confirmTitle:@"前往授权" cancelBlock:nil confirmBlock:^{
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url options:@{} completionHandler:nil];
            }
        }];
    });
}

- (void)presentAlertControllerWithTitle:(NSString *)title
                            cancelTitle:(NSString *)cancelTitle
                           confirmTitle:(NSString *)confirmTitle
                            cancelBlock:(dispatch_block_t)cancelBlock
                           confirmBlock:(dispatch_block_t)confirmBlock {
    UIAlertController *controller = [UIAlertController alertControllerWithTitle:nil
                                                                        message:title
                                                                 preferredStyle:UIAlertControllerStyleAlert];
    if (confirmTitle && confirmTitle.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:confirmTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (confirmBlock) {
                confirmBlock();
            }
        }];
        [controller addAction:action];
    }
    if (cancelTitle && cancelTitle.length) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [controller addAction:action];
    }
    [self.owner presentViewController:controller animated:YES completion:nil];
}


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
    [self startScan];
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *, id> *)dict {
    YXCDebugLogMethod();
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (_delegateFlag.respondsToDidDiscoverPeripheral) {
        [self.delegate yxc_blueToothManager:central didDiscoverPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
    }
}

/// 蓝牙设备连接成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    YXCLog(@"连接蓝牙设备%@成功", peripheral.name);
    if (_delegateFlag.respondsToDidConnectPeripheral) {
        [self.delegate yxc_blueToothManager:central didConnectPeripheral:peripheral];
    }
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    [self stopScan];
}

/// 蓝牙设备连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    YXCLog(@"连接蓝牙设备%@失败,错误信息:%@", peripheral.name, error.description);
    if (_delegateFlag.respondsToDidFailToConnectPeripheral) {
        [self.delegate yxc_blueToothManager:central didFailToConnectPeripheral:peripheral error:error];
    }
}

#pragma mark - CBPeripheralDelegate

- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    YXCLog(@"发现服务%@", peripheral);
}


#pragma mark - Lazy


@end
