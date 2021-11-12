//
//  YXCCAEmitterLayerController.m
//  YXCTools
//
//  Created by GGT on 2020/10/20.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCCAEmitterLayerController.h"

@interface YXCCAEmitterLayerController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView; /**< 列表 */
@property (nonatomic, strong) NSArray<YXCControllerModel *> *dataSources; /**< 数据源 */

@end

@implementation YXCCAEmitterLayerController

CAEmitterLayer *emitterLayer;

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}




#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)stopAnimation {
    [emitterLayer setValue:[NSNumber numberWithInteger:0] forKeyPath:@"emitterCells._myCell.birthRate"]; // new code
}

- (void)startAnimation {
    [self particle];
}


#pragma mark - Public


#pragma mark - Private

-(void)particle {
    emitterLayer = [CAEmitterLayer layer];
    emitterLayer.emitterPosition = CGPointMake(50 ,300);
    emitterLayer.emitterZPosition = 10;
    emitterLayer.emitterSize = CGSizeMake(10,10);
    emitterLayer.emitterShape = kCAEmitterLayerSphere;

    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    emitterCell.name = @"_myCell";// new code
    emitterCell.scale = 0.5;
    emitterCell.scaleRange = 0.8;
    emitterCell.emissionRange = (CGFloat)M_PI_2;
    emitterCell.lifetime = 10;
    emitterCell.birthRate = 5;
    emitterCell.velocity = 20;
    emitterCell.velocityRange = 50;
    emitterCell.yAcceleration = 0;

    emitterCell.contents = (id)[[UIImage imageNamed:@"snowflake"] CGImage];
    emitterLayer.emitterCells = [NSArray arrayWithObject:emitterCell];

    [self.view.layer addSublayer:emitterLayer];
}


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
            [YXCControllerModel modelWithClassName:@"YXCEmitterLiveController" title:@"直播间冒泡动画" parameter:nil],
            [YXCControllerModel modelWithClassName:@"YXCEmitterLikeController" title:@"点赞动画" parameter:nil],
        ];
    }
    
    return _dataSources;
}

@end
