//
//  YXCObserverController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCObserverController.h"
#import "YXCPerson.h"
#import "YXCObserverHandler.h"

@interface YXCObserverController ()<UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) YXCPerson *person;

@end

@implementation YXCObserverController

/// 刷新UI
- (void)injected {
    
}

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
    
    self.person = [YXCPerson new];
    [self.person yxc_addOberserForKeyPath:@"name" options:NSKeyValueObservingOptionNew change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        NSLog(@"Person外部监听name:%@", change[NSKeyValueChangeNewKey]);
    }];
    [self.person yxc_addOberserForKeyPath:@"age" newOldChange:^(NSObject * _Nullable object, id  _Nullable newValue, id  _Nullable oldValue) {
        NSLog(@"Person外部监听 -- age:%@", newValue);
    }];
    self.person.name = @"第一次设置Name";
    self.person.age = 10;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.person.name = @"第二次设置Name";
        self.person.age = 20;
    });
    
    YXCPerson *person1 = [YXCPerson new];
    [person1 yxc_addOberserForKeyPath:@"name" options:NSKeyValueObservingOptionNew change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        NSLog(@"Person1外部监听name:%@", change[NSKeyValueChangeNewKey]);
    }];
    person1.name = @"person1";
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"Person外部监听name:%@", change[NSKeyValueChangeNewKey]);
}


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [@(indexPath.row) stringValue];
    
    return cell;
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
    _tableView.dataSource = self;
    _tableView.backgroundColor = UIColor.whiteColor;
    _tableView.rowHeight = 50;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCellIdentifier];
    
    return _tableView;
}

@end
