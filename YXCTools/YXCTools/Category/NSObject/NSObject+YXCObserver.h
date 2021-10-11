//
//  NSObject+YXCObserver.h
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YXCKVOChangeBlock)(NSObject * _Nullable object, NSDictionary<NSKeyValueChangeKey, id> * _Nullable change);
typedef void(^YXCKVONewOldChangeBlock)(NSObject * _Nullable object, _Nullable id newValue, _Nullable id oldValue);

NS_ASSUME_NONNULL_BEGIN

/// 观察者模式
@interface NSObject (YXCObserver)

/// 添加监听
/// @param observer 监听对象
/// @param keyPath 被监听的对象
/// @param options 监听回调属性
/// @param handler 监听回调
- (void)yxc_addOberser:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
                change:(YXCKVOChangeBlock)handler;

/// 添加监听
/// @param observer 监听对象
/// @param keyPath 被监听的对象
/// @param options 监听回调属性
/// @param handler 监听回调
- (void)yxc_addOberser:(NSObject *)observer
            forKeyPath:(NSString *)keyPath
               options:(NSKeyValueObservingOptions)options
          newOldChange:(YXCKVONewOldChangeBlock)handler;

@end

NS_ASSUME_NONNULL_END
