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

- (void)yxc_addOberserForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options change:(YXCKVOChangeBlock)hanlder;

- (void)yxc_addOberserForKeyPath:(NSString *)keyPath newOldChange:(YXCKVONewOldChangeBlock)hanlder;

@end

NS_ASSUME_NONNULL_END
