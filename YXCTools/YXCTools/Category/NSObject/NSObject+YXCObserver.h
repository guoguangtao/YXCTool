//
//  NSObject+YXCObserver.h
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// KVO 回调
typedef void(^YXCKVOObservedChangeHandler)(NSDictionary<NSKeyValueChangeKey, id> * _Nullable change);

/// KVO 回调，只回调新值和旧值
typedef void(^YXCKVOObservedChangeNewOldHandler)(_Nullable id newValue, _Nullable id oldValue);



/// 观察者模式
@interface NSObject (YXCObserver)

/// 添加观察者
/// @param observer 观察对象（一般传入在哪个对象进行观察）
/// @param keyPath 被观察的属性
/// @param changeHandler KVO回调
- (void)yxc_addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
          changeHandler:(nullable YXCKVOObservedChangeHandler)changeHandler;

/// 添加观察者
/// @param observer 观察对象（一般传入在哪个对象进行观察）
/// @param keyPath 被观察的属性
/// @param options 被观察的属性观察通知中包含的内容
/// @param context 给观察者传递的参数
/// @param changeHandler KVO回调
- (void)yxc_addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                context:(nullable void *)context
          changeHandler:(nullable YXCKVOObservedChangeHandler)changeHandler;

/// 添加观察者
/// @param observer 观察对象（一般传入在哪个对象进行观察）
/// @param keyPath 被观察的属性
/// @param changeHandler KVO回调
- (void)yxc_addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
    changeNewOldHandler:(nullable YXCKVOObservedChangeNewOldHandler)changeHandler;

/// 添加观察者
/// @param observer 观察对象（一般传入在哪个对象进行观察）
/// @param keyPath 被观察的属性
/// @param options 被观察的属性观察通知中包含的内容
/// @param context 给观察者传递的参数
/// @param changeHandler KVO回调
- (void)yxc_addObserver:(NSObject *)observer
             forKeyPath:(NSString *)keyPath
                options:(NSKeyValueObservingOptions)options
                context:(nullable void *)context
    changeNewOldHandler:(nullable YXCKVOObservedChangeNewOldHandler)changeHandler;

@end

NS_ASSUME_NONNULL_END
