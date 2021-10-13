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

@interface __YXCKVOObserver : NSObject

@property (nonatomic, unsafe_unretained) NSObject *target;
@property (nonatomic, unsafe_unretained) NSObject *observer;
@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) YXCKVOChangeBlock changeBlock;
@property (nonatomic, copy) YXCKVONewOldChangeBlock newOldChangeBlock;

@end

@implementation __YXCKVOObserver

- (instancetype)initWithTarget:(NSObject *)target
                      observer:(NSObject *)observer
                    forKeyPath:(NSString *)keyPath
                       options:(NSKeyValueObservingOptions)options
                        change:(YXCKVOChangeBlock)changeHandler
                  newOldChange:(YXCKVONewOldChangeBlock)newOldChangeHandler {
    if (self = [super init]) {
        _target = target;
        _observer = observer;
        _keyPath = keyPath;
        _changeBlock = changeHandler;
        _newOldChangeBlock = newOldChangeHandler;
        [_target addObserver:self forKeyPath:keyPath options:options context:nil];
    }
    
    return self;
}

- (void)dealloc {
    NSLog(@"%s - %@", __func__, self);
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



#pragma mark - ======================== __YXCAutoRemoveObserver ========================

@interface __YXCAutoRemoveObserver : NSObject {
@public
    char _key;
}

@property (nonatomic, weak) __YXCAutoRemoveObserver *object;
@property (nonatomic, strong) __YXCKVOObserver *kvoObserver;
@property (nonatomic, copy) dispatch_block_t deallocBlock;

@end

@implementation __YXCAutoRemoveObserver

- (void)dealloc {
    NSLog(@"%s - %@", __func__, self);
    if (self.object) {
        NSLog(@"移除观察者");
        NSLog(@"target : %@, target.recount = %ld", self.object.kvoObserver.target, CFGetRetainCount((__bridge CFTypeRef)(self.object.kvoObserver.target)));
        [self.object.kvoObserver.target removeObserver:self.object.kvoObserver forKeyPath:self.object.kvoObserver.keyPath];
        if (self.deallocBlock) {
            self.deallocBlock();
        }
        self.object.kvoObserver = nil;
        self.object = nil;
    }
}

@end



#pragma mark - ======================== NSObject (YXCObserver) ========================

@interface NSObject (YXCObserver)

@property (nonatomic, strong) NSMutableSet<NSString *> *keyPathHashSet;

@end


@implementation NSObject (YXCObserver)

- (void)setKeyPathHashSet:(NSMutableSet<NSString *> *)keyPathHashSet {
    objc_setAssociatedObject(self, @selector(keyPathHashSet), keyPathHashSet, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableSet<NSString *> *)keyPathHashSet {
    NSMutableSet *set = objc_getAssociatedObject(self, @selector(keyPathHashSet));
    if (set == nil) {
        set = [NSMutableSet set];
        self.keyPathHashSet = set;
    }
    return set;
}

/// 添加监听
/// @param observer 监听对象
/// @param keyPath 被监听的对象
/// @param options 监听回调属性
/// @param handler 监听回调
- (void)yxc_addOberser:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
                change:(YXCKVOChangeBlock)handler {
    
    [self p_addOberser:observer forKeyPath:keyPath options:options change:handler newOldChange:nil];
}

/// 添加监听
/// @param observer 监听对象
/// @param keyPath 被监听的对象
/// @param handler 监听回调
- (void)yxc_addOberser:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
          newOldChange:(YXCKVONewOldChangeBlock)handler {
    
    [self p_addOberser:observer forKeyPath:keyPath options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld change:nil newOldChange:handler];
}

/// 添加监听
/// @param observer 监听对象
/// @param keyPath 被监听对象的属性
/// @param options 监听回调属性
/// @param changeHandler 整体返回
/// @param newOldChangeHanlder 只返回 new、old 值
- (void)p_addOberser:(NSObject *)observer
          forKeyPath:(NSString *)keyPath
             options:(NSKeyValueObservingOptions)options
              change:(YXCKVOChangeBlock)changeHandler
        newOldChange:(YXCKVONewOldChangeBlock)newOldChangeHanlder {
    
    @synchronized (self) {
    
        if (observer == nil || keyPath == nil || ![keyPath isKindOfClass:[NSString class]] || keyPath.length <= 0) {
            return;
        }
        
        NSString *hashstr = [NSString stringWithFormat:@"%lu-%lu-%@", (unsigned long)[self hash], (unsigned long)[observer hash], keyPath];
        if ([self.keyPathHashSet containsObject:hashstr]) {
            return;
        }
        [self.keyPathHashSet addObject:hashstr];
        
        __YXCAutoRemoveObserver *autoRemoveObserver = [__YXCAutoRemoveObserver new];
        __YXCAutoRemoveObserver *autoRemoveTarget = [__YXCAutoRemoveObserver new];
        autoRemoveTarget.object = autoRemoveObserver;
        autoRemoveObserver.object = autoRemoveTarget;
        __YXCKVOObserver *kvoObserver = [[__YXCKVOObserver alloc] initWithTarget:self observer:observer forKeyPath:keyPath options:options change:changeHandler newOldChange:newOldChangeHanlder];
        autoRemoveObserver.kvoObserver = kvoObserver;
        autoRemoveTarget.kvoObserver = kvoObserver;
        
        objc_setAssociatedObject(self, &autoRemoveTarget->_key, autoRemoveTarget, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        objc_setAssociatedObject(observer, &autoRemoveObserver->_key, autoRemoveObserver, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        __weak typeof(self) wkSelf = self;
        __weak typeof(observer) wkObserver = observer;
        __weak typeof(autoRemoveTarget) wkAutoRemoveTarget = autoRemoveTarget;
        __weak typeof(autoRemoveObserver) wkAutoRemoveObserver = autoRemoveObserver;
        NSLog(@"self = %@, self.recount = %ld", self, CFGetRetainCount((__bridge CFTypeRef)(self)));
        autoRemoveTarget.deallocBlock = ^{
            [wkSelf.keyPathHashSet removeObject:hashstr];
            __strong typeof(wkAutoRemoveObserver) autoRemoveObserver = wkAutoRemoveObserver;
            objc_setAssociatedObject(wkObserver, &autoRemoveObserver->_key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        };
        autoRemoveObserver.deallocBlock = ^{
            [wkSelf.keyPathHashSet removeObject:hashstr];
            __strong typeof(wkAutoRemoveTarget) autoRemoveTarget = wkAutoRemoveTarget;
            objc_setAssociatedObject(wkSelf, &autoRemoveTarget->_key, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        };
        NSLog(@"添加观察者 %@ - %@ = %@", autoRemoveTarget, autoRemoveObserver, kvoObserver);
    }
}


@end

