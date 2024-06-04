//
//  YXCTouchController.m
//  YXCTools
//
//  Created by guogt on 2024/6/4.
//  Copyright © 2024 GGT. All rights reserved.
//

#import "YXCTouchController.h"

@interface YXCTouchController ()

@property (nonatomic, strong) NSMutableSet *touches;

@end

@implementation YXCTouchController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.multipleTouchEnabled = true;
    self.touches = [NSMutableSet set];
    
    [self setupUI];
    [self setupConstraints];
}


#pragma mark - Custom Accessors (Setter 与 Getter 方法)


#pragma mark - IBActions

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.touches addObjectsFromArray:touches.allObjects];
    [self p_getTouches:self.touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self p_getTouches:self.touches];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self p_getTouches:self.touches];
    for (UITouch *touch in touches) {
        [self.touches removeObject:touch];
    }
}


#pragma mark - Public


#pragma mark - Private

- (void)p_getTouches:(NSSet<UITouch *> *)touches {
    
    NSArray *touchesArray = [NSArray arrayWithArray:touches.allObjects];
    NSLog(@"处理 touche : %ld", touchesArray.count);
    
    for (UITouch *touch in touches) {
        switch (touch.phase) {
            case UITouchPhaseBegan:
                NSLog(@"%ld - began", touch.hash);
                break;
            case UITouchPhaseMoved:
                NSLog(@"%ld - moved", touch.hash);
                break;
            case UITouchPhaseStationary:
                NSLog(@"%ld - Stationary", touch.hash);
                break;
            case UITouchPhaseEnded:
                NSLog(@"%ld - ended", touch.hash);
                break;
            case UITouchPhaseCancelled:
                NSLog(@"%ld - cancelled", touch.hash);
                break;
            case UITouchPhaseRegionEntered:
                NSLog(@"%ld - regionEntered", touch.hash);
                break;
            case UITouchPhaseRegionMoved:
                NSLog(@"%ld - regionMoved", touch.hash);
                break;
            case UITouchPhaseRegionExited:
                NSLog(@"%ld - regionExited", touch.hash);
                break;
        }
    }
}


#pragma mark - Protocol


#pragma mark - UI

- (void)setupUI {
    
    
}


#pragma mark - Constraints

- (void)setupConstraints {
    
    
}


#pragma mark - Lazy


@end
