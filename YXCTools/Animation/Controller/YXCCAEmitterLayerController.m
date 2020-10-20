//
//  YXCCAEmitterLayerController.m
//  YXCTools
//
//  Created by GGT on 2020/10/20.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "YXCCAEmitterLayerController.h"

@interface YXCCAEmitterLayerController ()



@end

@implementation YXCCAEmitterLayerController

#pragma mark - Lifecycle

/// 刷新UI
- (void)injected {
    
    for (CALayer *layer in self.view.layer.sublayers) {
        [layer removeFromSuperlayer];
    }
    
    [self setupUI];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    [self setupConstraints];
}

- (void)dealloc {
    
    YXCLog(@"%s", __func__);
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 创建一个粒子发射器
    CAEmitterLayer *emitterLayer = [[CAEmitterLayer alloc] init];
    // 设置粒子发射器的frame
    CGRect frame = CGRectMake(0, self.view.height * 0.5f, self.view.width, self.view.height * 0.5f);
    emitterLayer.frame = frame;
    // 添加
    [self.view.layer addSublayer:emitterLayer];
    // 粒子发射器的形状
    emitterLayer.emitterShape = kCAEmitterLayerLine;
    // 粒子发射器的模式
    emitterLayer.emitterMode = kCAEmitterLayerOutline;
    // 粒子发射器的中心位置
    emitterLayer.emitterPosition = CGPointMake(self.view.width - 30, frame.size.height - 30);
    // 粒子发射器的尺寸
    emitterLayer.emitterSize = CGSizeMake(20, 0);
    // 粒子发射器的深度
    emitterLayer.emitterDepth = 1.0f;
    
    // 一个粒子
    CAEmitterCell *emitterCell = [CAEmitterCell new];
    // 粒子的内容,设置成图片
    emitterCell.contents = (__bridge id)[UIImage imageNamed:@"snowflake"].CGImage;
    // 粒子产生速度
    emitterCell.birthRate = 4;
    // 粒子的存活时间
    emitterCell.lifetime = 3;
    // y 轴方向的加速度
    emitterCell.yAcceleration = -50;
    // x 轴方向的加速度
    emitterCell.xAcceleration = -10;
    // 初始速度
    emitterCell.velocity = 20;
    // 粒子发射角度
    emitterCell.emissionRange = -M_PI_2;
    // 缩放比例
    emitterCell.scale = 1.0f;
    // 缩放比例范围
    emitterCell.scaleRange = 2.0f;
    // 缩放比例速度
    emitterCell.scaleSpeed = 0.05f;
    // 旋转速度
    emitterCell.spin = 2.0f;
    // 旋转速度范围
    emitterCell.spinRange = 3.0f;
    // red 能改变的范围
    emitterCell.redRange = 1.0f;
    // red 改变速度
    emitterCell.redSpeed = 0.0f;
    // green 能改变的范围
    emitterCell.greenRange = 1.0f;
    // green 改变速度
    emitterCell.greenSpeed = 0.0f;
    // blue 能改变的范围
    emitterCell.blueRange = 1.0f;
    // blue 改变速度
    emitterCell.blueSpeed = 0.0f;
    
    emitterLayer.emitterCells = @[emitterCell];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - 懒加载

@end
