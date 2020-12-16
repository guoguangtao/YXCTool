//
//  NSDictionary+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSDictionary+YXC_Category.h"
#import <objc/runtime.h>

@implementation NSDictionary (YXC_Category)

+ (void)load {
    
    // @{} 字面量初始化
    [self hookInstanceMethodWithTargetCls:NSClassFromString(@"__NSPlaceholderDictionary")
                               currentCls:[self class]
                           targetSelector:@selector(initWithObjects:forKeys:count:)
                          currentSelector:@selector(yxc_NSPlaceholderDictionary_initWithObjects:forKeys:count:)];
    
    [self hookInstanceMethodWithTargetCls:[self class]
                               currentCls:[self class]
                           targetSelector:@selector(initWithObjects:forKeys:)
                          currentSelector:@selector(yxc_initWithObjects:forKeys:)];
}

/// 字面量初始化
/// 1. +[NSDictionary dictionaryWithObjects:forKeys:count:]
/// 2. -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]
/// *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSPlaceholderDictionary initWithObjects:forKeys:count:]: attempt to insert nil object from objects[3]'
/// @param objects 内容数组
/// @param keys key 数组
/// @param cnt 内容个数
- (instancetype)yxc_NSPlaceholderDictionary_initWithObjects:(id  _Nonnull const [])objects
                                                    forKeys:(id<NSCopying>  _Nonnull const [])keys
                                                      count:(NSUInteger)cnt {
    
    NSUInteger count = 0;
    
    NSMutableArray *keysArray = [NSMutableArray array];
    NSMutableArray *valuesArray = [NSMutableArray array];

    for (int i = 0; i < cnt; i++) {
        id key = keys[i];
        id value = objects[i];
        if (key == nil || value == nil) continue;
        [keysArray addObject:key];
        [valuesArray addObject:value];
        count++;
    }

    id objs[count];
    id keysArr[count];

    for (int i = 0; i < count; i++) {
        objs[i] = valuesArray[i];
        keysArr[i] = keysArray[i];
    }
    
    return [self yxc_NSPlaceholderDictionary_initWithObjects:objs forKeys:keysArr count:count];
}

/// 当 value 和 key 数量不一致时进行处理
/// @param objects 对象数组
/// @param keys key 数组
- (instancetype)yxc_initWithObjects:(NSArray *)objects forKeys:(NSArray<id<NSCopying>> *)keys {
    
    if (objects.count != keys.count) {
        // *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[NSDictionary initWithObjects:forKeys:]: count of objects (1) differs from count of keys (0)'
        NSMutableArray *objectsArray = [NSMutableArray array];
        NSMutableArray *keysArray = [NSMutableArray array];
        NSUInteger count = MIN(objects.count, keys.count);
        for (int i = 0; i < count; i++) {
            [objectsArray addObject:objects[i]];
            [keysArray addObject:keys[i]];
        }
        return [self yxc_initWithObjects:objectsArray forKeys:keysArray];
    }
    
    return [self yxc_initWithObjects:objects forKeys:keys];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    YXCLog(@"setValue:forUndefinedKey - %@ : %@", key, value);
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end
