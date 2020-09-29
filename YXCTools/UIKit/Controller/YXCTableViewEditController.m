//
//  YXCTableViewEditController.m
//  YXCTools
//
//  Created by GGT on 2020/9/28.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCTableViewEditController.h"
#import "YXCTableViewEditCell.h"

@interface YXCTableViewEditController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YXCTableViewEditController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigation];
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)editButtonClicked {
    
    BOOL edit = !self.tableView.isEditing;
    [self.tableView setEditing:edit animated:YES];
}


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCTableViewEditCell *cell = [YXCTableViewEditCell cellWithTableView:tableView indexPath:indexPath];
    
    return cell;
}


#pragma mark - UITableViewDelegate


#pragma mark - UI

- (void)setupNavigation {
    
    UIButton *editButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    [editButton setTitle:@"编辑" forState:UIControlStateNormal];
    [editButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
    [editButton addTarget:self action:@selector(editButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:editButton];
}

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableFooterView = [UIView new];
    self.tableView.rowHeight = 100;
    self.tableView.allowsMultipleSelectionDuringEditing = YES;
    [self.view addSubview:self.tableView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
