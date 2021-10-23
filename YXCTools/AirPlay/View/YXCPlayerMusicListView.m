//
//  YXCPlayerMusicListView.m
//  YXCTools
//
//  Created by lbkj on 2021/10/23.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCPlayerMusicListView.h"
#import "YXCMusicHandler.h"

@interface YXCPlayerMusicListView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger index;

@end


@implementation YXCPlayerMusicListView

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self setupUI];
        [self setupConstraints];
    }
    
    return self;
}

- (void)dealloc {
    
}

#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BOOL result = [touches.allObjects.firstObject.view isDescendantOfView:self.contentView];
    if (!result) {
        [self dismiss];
    }
}


#pragma mark - Public

- (void)show {
    UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
    self.frame = window.bounds;
    
    self.contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 300, CGRectGetWidth(self.frame), 300);
    if ([self.delegate respondsToSelector:@selector(currentPlayAtIndex:)]) {
        NSMutableArray<NSIndexPath *> *indexPaths = [NSMutableArray array];
        if (self.index != 0) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
            [indexPaths addObject:lastIndexPath];
        }
        
        self.index = [self.delegate currentPlayAtIndex:self];
        if (self.index <= 0) {
            self.index = 0;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index inSection:0];
        [indexPaths addObject:indexPath];
        @try {
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionNone animated:NO];
            [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationNone];
        } @catch (NSException *exception) {
        }
    }
}

- (void)dismiss {
    [self removeFromSuperview];
}


#pragma mark - Private


#pragma mark - Protocol

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [YXCMusicHandler shareInstance].musics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = [YXCMusicHandler shareInstance].musics[indexPath.row].musicName;
    if (self.index == indexPath.row) {
        cell.textLabel.textColor = UIColor.blueColor;
    } else {
        cell.textLabel.textColor = UIColor.blackColor;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([self.delegate respondsToSelector:@selector(listView:didSelectedAtIndex:)]) {
        [self.delegate listView:self didSelectedAtIndex:indexPath.row];
        [self dismiss];
    }
}


#pragma mark - UI

- (void)setupUI {
    
    self.contentView = [UIView new];
    self.contentView.backgroundColor = UIColor.grayColor;
    [self addSubview:self.contentView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = 50;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:kCellIdentifier];
    [self.contentView addSubview:self.tableView];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}


#pragma mark - Lazy


@end
