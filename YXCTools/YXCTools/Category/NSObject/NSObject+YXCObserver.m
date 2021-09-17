//
//  NSObject+YXCObserver.m
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "NSObject+YXCObserver.h"
#import <objc/runtime.h>

#pragma mark - ====================== __YXCObserverHandler ======================

/// 观察者助手
@interface __YXCObserverHandler : NSObject

@property (nonatomic, weak) NSObject *target;   /**< 被监听的对象 */
@property (nonatomic, copy) NSString *keyPath;  /**< 监听的属性 */
@property (nonatomic, copy) YXCKVOObservedChangeHandler changeHandler;  /**< KVO 回调 */

@end


@implementation __YXCObserverHandler

- (void)dealloc {
    
    if (_target) {
        [_target removeObserver:self forKeyPath:_keyPath];
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {

    if (object == self.target && [keyPath isEqualToString:self.keyPath]) {
        if (self.changeHandler) {
            self.changeHandler(change);
        }
    }
}

@end


#pragma mark - ====================== NSObject+YXCObserver ======================

@interface NSObject ()

@property (nonatomic, strong) NSMutableSet<NSString *> *keyPathSet;
@property (nonatomic, strong) NSMutableSet<__YXCObserverHandler *> *observerSet;

@end


@implementation NSObject (YXCObserver)

/// 添加观察者
/// @param observer 观察对象（一般传入在哪个对象进行观察）
/// @param keyPath 被监听的属性
/// @param options 被监听的属性观察通知中包含的内容
/// @param context 给观察者传递的参数
/// @param changeHandler KVO回调
- (void)yxc_addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                context:(nullable void *)context
          changeHandler:(nullable YXCKVOObservedChangeHandler)changeHandler {
    
    @synchronized (self) {
        if (keyPath == nil || ![keyPath isKindOfClass:[NSString class]] || keyPath.length <= 0) {
            return;
        }
        
        NSString *hashstr = [NSString stringWithFormat:@"%lu-%lu-%@", (unsigned long)[self hash], (unsigned long)[observer hash], keyPath];
        if ([self.keyPathSet containsObject:hashstr]) {
            return;
        }
        [self.keyPathSet addObject:hashstr];
        __YXCObserverHandler *handler = [__YXCObserverHandler new];
        handler.target = self;
        handler.keyPath = keyPath;
        handler.changeHandler = changeHandler;
        [self.observerSet addObject:handler];
        [self addObserver:handler forKeyPath:keyPath options:options context:context];
    }
}

- (NSMutableSet<NSString *> *)keyPathSet {
    
    NSMutableSet<NSString *> *set = objc_getAssociatedObject(self, _cmd);
    if (set) {
        return set;
    }
    set = [NSMutableSet set];
    objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return set;
}

- (NSMutableSet<__YXCObserverHandler *> *)observerSet {
    
    NSMutableSet<__YXCObserverHandler *> *set = objc_getAssociatedObject(self, _cmd);
    if (set) {
        return set;
    }
    set = [NSMutableSet set];
    objc_setAssociatedObject(self, _cmd, set, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return set;
}

@end

