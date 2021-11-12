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

static YXCPerson *_instance;

//+ (instancetype)shareInstance {
//    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (_instance == nil) {
//            _instance = [[self alloc] init];
//        }
//    });
//    
//    return _instance;
//}

//+ (instancetype)allocWithZone:(struct _NSZone *)zone {
//
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        if (_instance == nil) {
//            _instance = [super allocWithZone:zone];
//        }
//    });
//
//    return _instance;
//}

- (void)dealloc {
    
    YXCLog(@"%s - %@ retainCount : %ld", __func__, self, CFGetRetainCount((__bridge CFTypeRef)self));
}

- (instancetype)init {
    
    if (self = [super init]) {
//        [self yxc_addOberser:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew change:^(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey,id> * _Nullable change) {
//            YXCLog(@"Person 内部监听 name : %@", change[NSKeyValueChangeNewKey]);
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
