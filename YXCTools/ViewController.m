//
//  ViewController.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "ViewController.h"
#import "YXCController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    YXCController *controller = [YXCController new];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
