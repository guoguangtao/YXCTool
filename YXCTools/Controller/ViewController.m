//
//  ViewController.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表 */
@property (nonatomic, strong) NSArray<YXCControllerModel *> *dataSources; /**< 数据源 */

@end

@implementation ViewController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    self.dataSources = nil;
    [self setupUI];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];

    [self setupUI];
    [self setupConstraints];
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    delegate.navigationController = self.navigationController;
}

- (void)dealloc {
    
    YXCDebugLogMethod();
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (BOOL)isMute {
    
    __block BOOL result = YES;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self test:^{
        NSLog(@"Test 调用完成");
        result = NO;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    NSLog(@"返回结果");
    
    
    return result;
}

- (void)test:(void (^)(void))completion {
    
    NSLog(@"Test ---");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        if (completion) {
            completion();
        }
    });
    
}


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    YXCControllerModel *model = self.dataSources[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [YXCPushHandler pushController:self model:self.dataSources[indexPath.row]];
}




#pragma mark - UI

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.view addSubview:self.tableView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

- (NSArray *)dataSources {
    
    if (_dataSources == nil) {
        _dataSources = @[
            [YXCControllerModel modelWithClassName:@"YXCiOS16Controller" title:@"iOS16适配" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCiOS14Controller" title:@"iOS14适配" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCPhotoAlbumListController" title:@"PhotoKit的使用" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCTableViewEditController" title:@"UITableView多选状态" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCAnimationController" title:@"iOS 动画" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCLaunchImagesController" title:@"启动图制作" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCUIBezierPathController" title:@"UIBezierPath的使用" parameter:Nil],
            [YXCControllerModel modelWithClassName:@"YXCMultithreadingController" title:@"多线程" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCTestController" title:@"测试界面" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCBannerController" title:@"仿照华为音乐Banner" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCObserverController" title:@"观察者模式的使用" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCAirPlayAudioController" title:@"AirPlay播放音频" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCAudioController" title:@"播放音乐" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCBluetoothController" title:@"蓝牙使用" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCAutoLayoutController" title:@"AutoLayout的使用" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCScanQRCodeController" title:@"二维码扫描" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCTouchController" title:@"Touch" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCImageSynthesisController" title:@"照片合成" parameter:nil],
        ];
    }
    
    return _dataSources;
}

@end
