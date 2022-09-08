//
//  YXCEmitterLikeController.m
//  YXCTools
//
//  Created by GGT on 2020/10/22.
//  Copyright © 2020 GGT. All rights reserved.
//

#define EMITTERLAYER_BIRTHRATE 5

#import "YXCEmitterLikeController.h"

@interface YXCEmitterLikeController ()

@property (nonatomic, strong) UIButton *likeLineButton; /**< 直线上升动画 */
@property (nonatomic, strong) UIButton *circleButton; /**< 环绕动画 */
@property (nonatomic, strong) CAEmitterLayer *emitterLayer; /**< 粒子发射器 */

@end

@implementation YXCEmitterLikeController

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

- (void)startFire:(UIButton *)button {
    
    if (button == self.likeLineButton) {
        // 直线往上升
        self.emitterLayer.emitterShape = kCAEmitterLayerLine;
        self.emitterLayer.birthRate = 0.5;
        self.emitterLayer.emitterPosition = CGPointMake(button.centerX, button.centerY - button.height * 0.5);
    } else if (button == self.circleButton) {
        // 周围动画
        self.emitterLayer.birthRate = EMITTERLAYER_BIRTHRATE;
        self.emitterLayer.emitterShape = kCAEmitterLayerCircle;
        self.emitterLayer.emitterPosition = CGPointMake(button.centerX, button.centerY);
    }
    self.emitterLayer.beginTime = CACurrentMediaTime();
    // 3 秒后停止动画
    [self performSelector:@selector(stopFire) withObject:nil afterDelay:3];
    
    NSLog(@"%@", self.view.layer.sublayers);
}


#pragma mark - Public


#pragma mark - Private

- (void)stopFire {
    
    self.emitterLayer.birthRate = 0;
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    // 创建按钮
    self.likeLineButton = [UIButton new];
    self.likeLineButton.width = 40;
    self.likeLineButton.height = 40;
    self.likeLineButton.centerX = self.view.centerX;
    self.likeLineButton.centerY = 200;
    [self.likeLineButton setImage:[UIImage imageNamed:@"emitter_like"] forState:UIControlStateNormal];
    [self.likeLineButton addTarget:self action:@selector(startFire:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.likeLineButton];
    
    self.circleButton = [UIButton new];
    self.circleButton.width = 40;
    self.circleButton.height = 40;
    self.circleButton.centerX = self.view.centerX;
    self.circleButton.centerY = self.likeLineButton.centerY + 150;
    [self.circleButton setImage:[UIImage imageNamed:@"emitter_like"] forState:UIControlStateNormal];
    [self.circleButton addTarget:self action:@selector(startFire:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.circleButton];
}


#pragma mark - Constraints

- (void)setupConstraints {
    
}


#pragma mark - 懒加载

- (CAEmitterLayer *)emitterLayer {
    
    if (_emitterLayer == nil) {
        CAEmitterCell *cell = [CAEmitterCell emitterCell];
        cell.name = @"emitterCell";
        cell.contents = (__bridge id)[UIImage imageNamed:@"emitter_like"].CGImage;
        cell.birthRate = EMITTERLAYER_BIRTHRATE;
        cell.lifetime = 3;
        cell.velocity = 50;
        cell.scale = 0.2;
        cell.spin = 3.0f;
        
        // 创建粒子发射器
        CAEmitterLayer *layer = [CAEmitterLayer new];
        // 设置粒子发射器的 frame
        layer.frame = self.view.bounds;
        // 设置粒子发射器 name
        layer.name = @"emitterLayer";
        layer.emitterCells = @[cell];
        layer.emitterPosition = CGPointMake(self.likeLineButton.centerX, self.likeLineButton.centerY - self.likeLineButton.height * 0.5);
        layer.emitterSize = self.likeLineButton.size;
        layer.emitterShape = kCAEmitterLayerLine;
        layer.emitterMode = kCAEmitterLayerOutline;
        layer.renderMode = kCAEmitterLayerOldestFirst;
        layer.emitterDepth = 1.0f;
        
        [self.view.layer addSublayer:layer];
        _emitterLayer = layer;
    }
    
    return _emitterLayer;
}

@end
