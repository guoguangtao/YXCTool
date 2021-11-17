//
//  YXCBluetoothController.m
//  YXCTools
//
//  Created by lbkj on 2021/11/6.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCBluetoothController.h"
#import "YXCBlueToothManager.h"

@interface YXCBluetoothController ()<UITableViewDelegate, UITableViewDataSource, YXCBlueToothManagerDelegate>

@property (nonatomic, strong) NSMutableArray<CBPeripheral *> *dataSources;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YXCBluetoothController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
    [YXCBlueToothManager shareInstance].delegate = self;
    [[YXCBlueToothManager shareInstance] startScan];
}

- (void)dealloc {
    
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)addDevice:(CBPeripheral *)peripheral {
    @synchronized (self) {
        YXCLog(@"添加新设备 name:%@, identifier:%@, UUIDString:%@", peripheral.name, peripheral.identifier, peripheral.identifier.UUIDString);
        [self.dataSources addObject:peripheral];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(reloadDevices) object:nil];
        [self performSelector:@selector(reloadDevices) withObject:nil afterDelay:3.0f];
    });
}

- (void)reloadDevices {
    [self.tableView reloadData];
}


#pragma mark - Protocol

#pragma mark - UITableViewDataSource
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataSources[indexPath.row].name;
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[YXCBlueToothManager shareInstance] connectPeripheral:self.dataSources[indexPath.row] options:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

#pragma mark - YXCBlueToothManagerDelegate

- (void)yxc_blueToothManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    if (peripheral.name && peripheral.name.length) {
        for (CBPeripheral *p in self.dataSources) {
            if ([p.name isEqualToString:peripheral.name]) {
                return;
            }
        }
        [self addDevice:peripheral];
    }
}


#pragma mark - UI

- (void)setupUI {
    
    [self.view addSubview:self.tableView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}


#pragma mark - Lazy

- (UITableView *)tableView {
    if (_tableView) {
        return _tableView;
    }
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellIdentifier];
    return _tableView;
}

- (NSMutableArray<CBPeripheral *> *)dataSources {
    if (_dataSources) return _dataSources;
    
    _dataSources = [NSMutableArray array];
    return _dataSources;
}


@end
