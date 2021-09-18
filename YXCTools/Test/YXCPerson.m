//
//  YXCPerson.m
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCPerson.h"

@implementation YXCPerson


#pragma mark - Lifecycle

- (void)dealloc {
    
    NSLog(@"%s", __func__);
}

- (instancetype)init {
    
    if (self = [super init]) {
//        [self yxc_addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context:nil changeHandler:^(NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
//            NSLog(@"Person内部监听name:%@", change[NSKeyValueChangeNewKey]);
//        }];
    }
    
    return self;
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
