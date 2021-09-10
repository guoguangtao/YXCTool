//
//  YXCCoreAnimationController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCCoreAnimationController.h"

@interface YXCCoreAnimationController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray<YXCControllerModel *> *dataSources; /**< 数据源 */
@property (nonatomic, strong) UITableView *tableView; /**< tableView */

@end

@implementation YXCCoreAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Core Animation";
    self.view.backgroundColor = UIColor.whiteColor;

    [self setupUI];
    [self setupConstraints];
}

- (void)injected {
    
    [self.view yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    YXCControllerModel *model = self.dataSources[indexPath.row];
    cell.textLabel.text = model.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [YXCPushHandler pushController:self model:self.dataSources[indexPath.row]];
}


- (void)setupUI {
    
    [self.view addSubview:self.tableView];
}

- (void)setupConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (UITableView *)tableView {
    
    if (_tableView) {
        return _tableView;
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    return _tableView;
}

- (NSArray<YXCControllerModel *> *)dataSources {
    
    if (_dataSources) {
        return _dataSources;
    }
    
    _dataSources = @[
        [YXCControllerModel modelWithClassName:@"YXCLeBoHomeAnimationController" title:@"首页动画" parameter:nil],
    ];
    
    return _dataSources;
}

@end
