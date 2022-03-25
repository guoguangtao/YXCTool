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
@property (nonatomic, strong, readwrite) CBPeripheral *connectingPeripheral; /**< 当前连接的蓝牙设备 */
@property (nonatomic, strong) CBCharacteristic *readCharacteristic; /**< 读属性特征 */
@property (nonatomic, strong) CBCharacteristic *writeCharacteristic; /**< 写属性特征 */
@property (nonatomic, strong) CBCharacteristic *notifyCharacteristic; /**< 通知属性特征 */

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
        case CBManagerStateUnauthorized: {
            // 未授权，进行申请权限
            [self bluetoothUnauthorized];
        }   break;;
            
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
    // 判断是否是同一台设备
    if ([peripheral.identifier.UUIDString isEqualToString:self.connectingPeripheral.identifier.UUIDString]) {
        // 同一台设备不处理
        YXCLog(@"将要连接的设备%@跟目前连接的设备%@一致，不处理!", peripheral, self.connectingPeripheral);
        return;
    }
    // 先断开上一次连接的设备
    [self cancelPeripheralConnection:self.connectingPeripheral];
    // 连接当前目标设备
    [self.manager connectPeripheral:peripheral options:options];
    // 观察目标设备的连接状态
    NSKeyValueObservingOptions ops = NSKeyValueObservingOptionNew;
    [peripheral yxc_addOberser:self
                    forKeyPath:@"state"
                       options:ops
                        change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        YXCLog(@"设备连接状态发生改变:%@", object);
    }];
}

/// 断开连接
- (void)cancelPeripheralConnection:(CBPeripheral *)peripheral {
    if (peripheral &&
        (peripheral.state == CBPeripheralStateConnected ||
         peripheral.state == CBPeripheralStateConnecting)) {
        // 目标设备已连接或者正在连接中，断开连接
        [self.manager cancelPeripheralConnection:peripheral];
        return;
    }
    if (self.connectingPeripheral &&
        (self.connectingPeripheral.state == CBPeripheralStateConnected ||
        self.connectingPeripheral.state == CBPeripheralStateConnecting)) {
        // 当前设备已连接或者正在连接中，断开连接
        [self.manager cancelPeripheralConnection:self.connectingPeripheral];
    }
}

/// 发送文本
- (void)sendText:(NSString *)text {
    if (self.writeCharacteristic == nil) {
        return;
    }
    if (text == nil || !text.length) {
        return;
    }
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [self.connectingPeripheral writeValue:data forCharacteristic:self.writeCharacteristic type:CBCharacteristicWriteWithResponse];
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

/// 根据扫描到的特征，拼接当前特征的属性
/// @param characteristic 特征
- (NSString *)characteristicPropertiesString:(CBCharacteristic *)characteristic {
    NSMutableString *mutableString = [NSMutableString new];
    CBCharacteristicProperties properties = characteristic.properties;
    if (properties & CBCharacteristicPropertyBroadcast) {
        [mutableString appendString:@"CBCharacteristicPropertyBroadcast | "];
    }
    if (properties & CBCharacteristicPropertyRead) {
        [mutableString appendString:@"CBCharacteristicPropertyRead | "];
    }
    if (properties & CBCharacteristicPropertyWriteWithoutResponse) {
        [mutableString appendString:@"CBCharacteristicPropertyWriteWithoutResponse | "];
    }
    if (properties & CBCharacteristicPropertyWrite) {
        [mutableString appendString:@"CBCharacteristicPropertyWrite | "];
    }
    if (properties & CBCharacteristicPropertyNotify) {
        [mutableString appendString:@"CBCharacteristicPropertyNotify | "];
    }
    if (properties & CBCharacteristicPropertyIndicate) {
        [mutableString appendString:@"CBCharacteristicPropertyIndicate | "];
    }
    if (properties & CBCharacteristicPropertyAuthenticatedSignedWrites) {
        [mutableString appendString:@"CBCharacteristicPropertyAuthenticatedSignedWrites | "];
    }
    if (properties & CBCharacteristicPropertyExtendedProperties) {
        [mutableString appendString:@"CBCharacteristicPropertyExtendedProperties | "];
    }
    if (properties & CBCharacteristicPropertyNotifyEncryptionRequired) {
        [mutableString appendString:@"CBCharacteristicPropertyNotifyEncryptionRequired | "];
    }
    if (properties & CBCharacteristicPropertyIndicateEncryptionRequired) {
        [mutableString appendString:@"CBCharacteristicPropertyIndicateEncryptionRequired | "];
    }
    NSString *string = [NSString stringWithString:mutableString];
    if (mutableString.length > 2) {
        string = [mutableString stringByReplacingCharactersInRange:NSMakeRange(mutableString.length - 2, 2) withString:@""];
    }
    return string;
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate yxc_blueToothManager:central didDiscoverPeripheral:peripheral advertisementData:advertisementData RSSI:RSSI];
        });
    }
}

/// 蓝牙设备连接成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
    YXCLog(@"连接蓝牙设备%@成功", peripheral.name);
    if (_delegateFlag.respondsToDidConnectPeripheral) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate yxc_blueToothManager:central didConnectPeripheral:peripheral];
        });
    }
    self.connectingPeripheral = peripheral;
    peripheral.delegate = self;
    [peripheral discoverServices:nil];
    // 连接了设备成功后停止扫描蓝牙设备
    [self stopScan];
}

/// 蓝牙设备连接失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    YXCLog(@"连接蓝牙设备%@失败,错误信息:%@", peripheral.name, error.description);
    if (_delegateFlag.respondsToDidFailToConnectPeripheral) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.delegate yxc_blueToothManager:central didFailToConnectPeripheral:peripheral error:error];
        });
    }
}

/// 蓝牙设备连接断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    YXCLog(@"蓝牙设备断开连接:%@, 错误信息:%@", peripheral, error.description);
    self.connectingPeripheral = nil;
}

#pragma mark - CBPeripheralDelegate

/// 发现服务回调
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverServices:(nullable NSError *)error {
    YXCLog(@"发现服务 %@, error:%@", peripheral, error);
    if (error) {
        return;
    }
    for (CBService *service in peripheral.services) {
        // 扫描特征
        YXCLog(@"扫描服务 %@ 中的特征", service);
        [peripheral discoverCharacteristics:nil forService:service];
    }
}

/// 发现特征
- (void)peripheral:(CBPeripheral *)peripheral didDiscoverCharacteristicsForService:(CBService *)service error:(NSError *)error {
    YXCLog(@"%@ 在 %@发现特征, error:%@", peripheral, service, error);
    // 遍历服务中所有的特征
    for (CBCharacteristic *characteristic in service.characteristics) {
        YXCLog(@"发现特征:%@, %@", characteristic, [self characteristicPropertiesString:characteristic]);
        // 判断特征是否有读权限
        if (characteristic.properties & CBCharacteristicPropertyRead) {
            self.readCharacteristic = characteristic;
        }
        // 判断特征是否有写入权限
        if (characteristic.properties & CBCharacteristicPropertyWrite ||
            characteristic.properties & CBCharacteristicPropertyWriteWithoutResponse) {
            self.writeCharacteristic = characteristic;
        }
        // 判断特征是否有通知权限
        if (characteristic.properties & CBCharacteristicPropertyNotify) {
            self.notifyCharacteristic = characteristic;
            [peripheral setNotifyValue:YES forCharacteristic:characteristic];
        }
    }
}

- (void)peripheral:(CBPeripheral *)peripheral didWriteValueForCharacteristic:(CBCharacteristic *)characteristic error:(nullable NSError *)error {
    YXCDebugLogMethod();
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.connectingPeripheral readValueForCharacteristic:self.readCharacteristic];
    });
}

- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(CBCharacteristic *)characteristic error:(NSError *)error {
    YXCDebugLogMethod();
    NSData *data = characteristic.value;
    if (data == nil) {
        return;
    }
    NSString *string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    YXCLog(@"UTF-8:%@", string);
    string = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    YXCLog(@"ASCII:%@", string);
}


#pragma mark - Lazy


@end
