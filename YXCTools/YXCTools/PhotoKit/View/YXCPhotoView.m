//
//  YXCPhotoView.m
//  YXCTools
//
//  Created by GGT on 2020/9/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCPhotoView.h"
#import "YXCPhotoHandler.h"
#import "YXCPhotoListCell.h"

@interface YXCPhotoView ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView; /**< tableView */
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSources; /**< 数据源 */
@property (nonatomic, strong) NSMutableArray<YXCControllerModel *> *pushModelArray; /**< 跳转模型数据 */

@property (nonatomic, weak) UIViewController *owner; /**< 拥有者 */

@end

@implementation YXCPhotoView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    [self yxc_removeAllSubView];
    
    [self setupUI];
    [self setupConstraints];
    [self getPhotos];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.tableView.frame = self.bounds;
}

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public

+ (instancetype)photoViewWithOwner:(UIViewController *)owner {
    
    return [[YXCPhotoView alloc] initWithOwner:owner];
}

- (instancetype)initWithOwner:(UIViewController *)owner {
    
    if (self = [super init]) {
        
        self.owner = owner;
        
        [self setupUI];
        [self setupConstraints];
        [self getPhotos];
    }
    
    return self;
}


#pragma mark - Private

- (void)getPhotos {
    
    // 先查看相册是否授权
    BOOL authorizationStatus = [YXCPhotoHandler photoAuthorizationStatus:^(PHAuthorizationStatus status) {
        // 第一次授权,等待授权操作完成
        [self getPhotos];
    }];
    
    // 未授权
    if (!authorizationStatus) return;
}

- (void)setupPushModel {
    
    self.pushModelArray = [NSMutableArray array];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (NSDictionary *dict in self.dataSources) {
            YXCControllerModel *model = [YXCControllerModel modelWithClassName:@"YXCPhotoListController"
                                                                         title:dict[@"name"]
                                                                     parameter:dict];
            [self.pushModelArray addObject:model];
        }
    });
}


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YXCPhotoListCell *cell = [YXCPhotoListCell cellWithTableView:tableView indexPath:indexPath];
    cell.textLabel.text = self.dataSources[indexPath.row][@"name"];
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.owner) {
        [YXCPushHandler pushController:self.owner model:self.pushModelArray[indexPath.row]];
    }
}


#pragma mark - UI

- (void)setupUI {
    
    self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self addSubview:self.tableView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
