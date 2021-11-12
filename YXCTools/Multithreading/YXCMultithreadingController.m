//
//  YXCMultithreadingController.m
//  YXCTools
//
//  Created by GGT on 2020/11/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCMultithreadingController.h"

@interface YXCMultithreadingController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表 */
@property (nonatomic, strong) NSArray<YXCControllerModel *> *dataSources; /**< 数据源 */

@end

@implementation YXCMultithreadingController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}




#pragma mark - Custom Accessors (Setter 与 Getter 方法)


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
            [YXCControllerModel modelWithClassName:@"YXCPthreadController" title:@"Pthread" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCNSThreadController" title:@"NSThread" parameter:nil]
        ];
    }
    
    return _dataSources;
}

@end
