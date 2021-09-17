//
//  YXCObserverController.m
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCObserverController.h"
#import "YXCPerson.h"

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
    [self.person yxc_addObserver:self forKeyPath:@"name" changeNewOldHandler:^(NSString *newValue, NSString *oldValue) {
        NSLog(@"Person内部监听name:新值-%@, 旧值-%@", newValue, oldValue);
    }];
    self.person.name = @"Jack";
    YXCWeakSelf(self);
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        weakself.person.name = @"Tom";
    });
    
    [self.tableView yxc_addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil changeHandler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
        NSLog(@"chage : %@", change);
    }];
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
