//
//  NSObject+YXCObserver.m
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "NSObject+YXCObserver.h"
#import <objc/runtime.h>

#pragma mark - ======================== __YXCKVOObserver ========================

@interface __YXCKVOObserver : NSObject {
@public
    char _key;
}

@property (nonatomic, unsafe_unretained) NSObject *target;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) YXCKVOChangeBlock changeBlock;
@property (nonatomic, copy) YXCKVONewOldChangeBlock newOldChangeBlock;

@end

@implementation __YXCKVOObserver

- (instancetype)initWithTarget:(NSObject *)target
                    forKeyPath:(NSString *)keyPath
                       options:(NSKeyValueObservingOptions)options
                        change:(YXCKVOChangeBlock)hanlder {
    if (self = [super init]) {
        _target = target;
        _keyPath = keyPath;
        _changeBlock = hanlder;
        [_target addObserver:self forKeyPath:keyPath options:options context:nil];
    }
    
    return self;
}

- (instancetype)initWithTarget:(NSObject *)target
                    forKeyPath:(NSString *)keyPath
                       options:(NSKeyValueObservingOptions)options
                        newOldChange:(YXCKVONewOldChangeBlock)hanlder {
    if (self = [super init]) {
        _target = target;
        _keyPath = keyPath;
        _newOldChangeBlock = hanlder;
        [_target addObserver:self forKeyPath:keyPath options:options context:nil];
    }
    
    return self;
}

- (void)dealloc {
    if (_target) {
        @try {
            [_target removeObserver:self forKeyPath:_keyPath];
        } @catch (NSException *exception) {
        }
    }
}
- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey,id> *)change context:(nullable void *)context {
    if (self.changeBlock) {
        self.changeBlock(object, change);
    }
    if (self.newOldChangeBlock) {
        self.newOldChangeBlock(object, change[NSKeyValueChangeNewKey], change[NSKeyValueChangeOldKey]);
    }
}

@end

#pragma mark - ======================== NSObject (YXCObserver) ========================

@implementation NSObject (YXCObserver)

- (void)yxc_addOberserForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options change:(YXCKVOChangeBlock)hanlder {
    
    __YXCKVOObserver *observer = [[__YXCKVOObserver alloc] initWithTarget:self forKeyPath:keyPath options:options change:hanlder];
    objc_setAssociatedObject(self, &observer->_key, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)yxc_addOberserForKeyPath:(NSString *)keyPath newOldChange:(YXCKVONewOldChangeBlock)hanlder {
    __YXCKVOObserver *observer = [[__YXCKVOObserver alloc] initWithTarget:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld newOldChange:hanlder];
    objc_setAssociatedObject(self, &observer->_key, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end

