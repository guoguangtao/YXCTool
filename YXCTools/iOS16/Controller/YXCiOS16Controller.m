//
//  YXCiOS16Controller.m
//  YXCTools
//
//  Created by guogt on 2022/9/8.
//  Copyright © 2022 GGT. All rights reserved.
//

#import "YXCiOS16Controller.h"

@interface YXCiOS16Controller ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< 列表 */
@property (nonatomic, strong) NSArray<YXCControllerModel *> *dataSources; /**< 数据源 */

@end

@implementation YXCiOS16Controller

/// 刷新UI
- (void)injected {

    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }

    [self setupUI];
    [self setupConstraints];
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(injected) name:@"INJECTION_BUNDLE_NOTIFICATION" object:nil];
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {

    NSLog(@"%s", __func__);
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


#pragma mark - Lazy

- (NSArray *)dataSources {

    if (_dataSources == nil) {
        _dataSources = @[
            [YXCControllerModel modelWithClassName:@"YXCLaunchScreenController" title:@"横竖屏切换" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCUIPasteController" title:@"UIPasteControl的使用" parameter:nil],
        ];
    }

    return _dataSources;
}


@end
