//
//  ViewController.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "ViewController.h"

#if !SUPPORT_TAGGED_POINTERS  ||  (TARGET_OS_OSX || TARGET_OS_IOSMAC)
#   define SUPPORT_MSB_TAGGED_POINTERS 0
#else
#   define SUPPORT_MSB_TAGGED_POINTERS 1
#endif

#if !SUPPORT_INDEXED_ISA  &&  !SUPPORT_PACKED_ISA
#   define SUPPORT_NONPOINTER_ISA 0
#else
#   define SUPPORT_NONPOINTER_ISA 1
#endif


@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表 */
@property (nonatomic, strong) NSArray<YXCControllerModel *> *dataSources; /**< 数据源 */

@end

@implementation ViewController

/// 刷新UI
- (void)injected {
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
    
    [NSArray printfMethodWithSelector:@selector(init) isClassMethod:NO];
    [NSNumber printfMethodWithSelector:@selector(init) isClassMethod:NO];
    
    YXCLog(@"SUPPORT_NONPOINTER_ISA : %d", SUPPORT_NONPOINTER_ISA);
}

- (void)dealloc {
    
    YXCDebugLogMethod();
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)

- (BOOL)isMute {
    
    __block BOOL result = YES;
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    [self test:^{
        YXCLog(@"Test 调用完成");
        result = NO;
        dispatch_semaphore_signal(semaphore);
    }];
    
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    YXCLog(@"返回结果");
    
    
    return result;
}

- (void)test:(void (^)(void))completion {
    
    YXCLog(@"Test ---");
    
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
            [YXCControllerModel modelWithClassName:@"YXCiOS14Controller" title:@"iOS14适配" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCPhotoAlbumListController" title:@"PhotoKit的使用" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCTableViewEditController" title:@"UITableView多选状态" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCAnimationController" title:@"iOS 动画" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCLaunchImagesController" title:@"启动图制作" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCUIBezierPathController" title:@"UIBezierPath的使用" parameter:Nil],
            [YXCControllerModel modelWithClassName:@"YXCMultithreadingController" title:@"多线程" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCTestController" title:@"测试界面" parameter:nil],
        ];
    }
    
    return _dataSources;
}

@end
