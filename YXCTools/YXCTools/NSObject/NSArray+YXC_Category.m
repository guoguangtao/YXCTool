//
//  NSArray+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSArray+YXC_Category.h"
#import <objc/runtime.h>

@implementation NSArray (YXC_Category)

+ (void)load {
    
    [self hookMethod:[self class]
      originSelector:@selector(arrayWithObjects:count:)
    swizzledSelector:@selector(yxc_arrayWithObjects:count:)
         classMethod:YES];
    
//    [self hookOriginClass:NSClassFromString(@"__NSPlaceholderArray") currentClass:[self class] originSelector:@selector(initWithObjects:count:) swizzledSelector:@selector(yxc_initWithObjects:count:) classMethod:NO];
    
    Method system_objectAtIndexedSubscriptMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:));
    Method yxc_objectAtIndexedSubscriptMethod = class_getInstanceMethod(self, @selector(yxc_objectAtIndexedSubscript:));
    method_exchangeImplementations(system_objectAtIndexedSubscriptMethod, yxc_objectAtIndexedSubscriptMethod);
    
    Method system_objectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:));
    Method yxc_objectAtIndexMethod = class_getInstanceMethod(self, @selector(yxc_objectAtIndex:));
    method_exchangeImplementations(system_objectAtIndexMethod, yxc_objectAtIndexMethod);
    
    Method system_addObjectMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:));
    Method yxc_addObjectMethod = class_getInstanceMethod(self, @selector(yxc_addObject:));
    method_exchangeImplementations(system_addObjectMethod, yxc_addObjectMethod);
    
    Method system_insertObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:));
    Method yxc_insertObjectAtIndexMethod = class_getInstanceMethod(self, @selector(yxc_insertObject:atIndex:));
    method_exchangeImplementations(system_insertObjectAtIndexMethod, yxc_insertObjectAtIndexMethod);
    
    Method system_removeObjectAtIndexMethod = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:));
    Method yxc_removeObjectAtIndexMethod = class_getInstanceMethod(self, @selector(yxc_removeObjectAtIndex:));
    method_exchangeImplementations(system_removeObjectAtIndexMethod, yxc_removeObjectAtIndexMethod);
    
    // 此处是可变数组的取值方法替换
    Method system_objectAtIndexedSubscriptMethod1 = class_getInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:));
    Method yxc_objectAtIndexedSubscriptMethod1 = class_getInstanceMethod(self, @selector(yxc_objectAtIndexedSubscript1:));
    method_exchangeImplementations(system_objectAtIndexedSubscriptMethod1, yxc_objectAtIndexedSubscriptMethod1);
}

/**
 @[] 字面量初始化调用方法
 
 @param objects 对象
 @param cnt 数组个数
 @return 数组
 */
+ (instancetype)yxc_arrayWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    
    NSMutableArray *objectArray = [NSMutableArray array];
    
    for (int i = 0; i < cnt; i++) {
        id object = objects[i];
        if (object && ![object isKindOfClass:[NSNull class]]) {
            [objectArray addObject:object];
        }
    }
    
    return [NSArray arrayWithArray:objectArray];
}

- (instancetype)yxc_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    
    // 计算不为 nil 的数组元素个数
    NSUInteger count = 0;
    for (int i = 0; i < cnt; i++) {
        if (objects[i] != nil) {
            count++;
        }
    }
    // 根据统计出来不为 nil 的元素个数创建一个数组
    id arr[count];
    // 索引
    NSUInteger index = 0;
    for (int i = 0; i < cnt; i++) {
        if (objects[i] != nil) {
            // 将不为 nil 的元素添加到新数组中去
            arr[index] = objects[i];
        }
    }
    
    return [self yxc_initWithObjects:arr count:count];
}

/**
 数组添加一个对象
 */
- (void)yxc_addObject:(id)anObject {
    
    if (!anObject) return;
    [self yxc_addObject:anObject];
}

/**
 数组插入一个对象
 
 @param anObject 对象
 @param index 待插入的下标
 */
- (void)yxc_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    if (!anObject) return;
    if (index > self.count) return; // 数组可以插入下标为0这个位置，如果此处 >= 会有问题
    
    [self yxc_insertObject:anObject atIndex:index];
}

/**
 根据下标移除某个对象
 
 @param index 需要移除的下标
 */
- (void)yxc_removeObjectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) return;
    
    [self yxc_removeObjectAtIndex:index];
}

/**
 通过 index 获取对象
 
 @param index 数组下标
 */
- (id)yxc_objectAtIndex:(NSUInteger)index {
    
    if (index >= self.count) return nil;
    
    return [self yxc_objectAtIndex:index];
}

/**
 @[] 形式获取数组对象
 
 @param idx 数组下标
 */
- (id)yxc_objectAtIndexedSubscript:(NSUInteger)idx {
    
    if (idx >= self.count) return nil;
    
    return [self objectAtIndex:idx];
}

/**
 @[] 形式获取数组对象
 
 @param idx 数组下标
 */
- (id)yxc_objectAtIndexedSubscript1:(NSUInteger)idx {
    
    if (idx >= self.count) return nil;
    
    return [self objectAtIndex:idx];
}

/// 打印数组
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    
    return strM;
}

/// 将数组的每个元素,进行拼接
- (NSString * _Nonnull (^)(NSString * _Nonnull))yxc_joinedByString {
    
    return ^(NSString *separator) {
        return [self componentsJoinedByString:separator];
    };
}

/// 通过链式编程,添加另外一个数组
- (NSArray * _Nonnull (^)(NSArray * _Nonnull))yxc_addObjects {
    
    return ^(NSArray *array) {
        NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:self];
        [mutableArray addObjectsFromArray:array];
        
        return [NSArray arrayWithArray:mutableArray];
    };
}

@end
