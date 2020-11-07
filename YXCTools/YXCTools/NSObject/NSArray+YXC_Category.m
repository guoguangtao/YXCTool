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
    
    // NSArray @[] 字面量
    [self hookOriginClass:NSClassFromString(@"__NSPlaceholderArray")
             currentClass:[self class]
           originSelector:@selector(initWithObjects:count:)
         swizzledSelector:@selector(yxc_NSPlaceholderArray_initWithObjects:count:)
              classMethod:NO];
    
    // 当数组为空数组时，数组的类型为 __NSArray0，内部重新实现了 objectAtIndex: 方法，需要对 __NSArray0 类进行 hook 操作
    [self hookOriginClass:NSClassFromString(@"__NSArray0")
             currentClass:[self class]
           originSelector:@selector(objectAtIndex:)
         swizzledSelector:@selector(yxc_NSArray0_objectAtIndex:)
              classMethod:NO];
    
    // 当数组元素为 1 个时，数组的类型为 __NSSingleObjectArrayI，内部重新实现了 objectAtIndex: 方法，需要对 __NSSingleObjectArrayI 类进行 hook 操作
    [self hookOriginClass:NSClassFromString(@"__NSSingleObjectArrayI")
             currentClass:[self class]
           originSelector:@selector(objectAtIndex:)
         swizzledSelector:@selector(yxc_NSSingleObjectArrayI_objectAtIndex:)
              classMethod:NO];
    
    // 当数组元素为多个时，数组的类型为 __NSArrayI，内部重新实现了 objectAtIndexedSubscript: 方法，使用该方法对系统方法进行 hook
    [self hookOriginClass:NSClassFromString(@"__NSArrayI")
             currentClass:[self class]
           originSelector:@selector(objectAtIndexedSubscript:)
         swizzledSelector:@selector(yxc_NSArrayI_objectAtIndexedSubscript:)
              classMethod:NO];
    
    // 当数组元素为多个时，数组的类型为 __NSArrayI，内部重新实现了 objectAtIndex: 方法，使用该方法对系统方法进行 hook
    [self hookOriginClass:NSClassFromString(@"__NSArrayI")
             currentClass:[self class]
           originSelector:@selector(objectAtIndex:)
         swizzledSelector:@selector(yxc_NSArrayI_objectAtIndex:)
              classMethod:NO];
    
    // 不可变数组，根据某个对象和范围获取索引值，在这不区分 __NSArray0、__NSSingleObjectArrayI、__NSArrayI 类型
    [self hookMethod:[self class]
      originSelector:@selector(indexOfObject:inRange:)
    swizzledSelector:@selector(yxc_indexOfObject:inRange:)
         classMethod:NO];
    
    // 不可变数组，根据 indexSet 获取某个元素,在这不区分 __NSArray0、__NSSingleObjectArrayI、__NSArrayI 类型
    [self hookMethod:[self class]
      originSelector:@selector(objectsAtIndexes:)
    swizzledSelector:@selector(yxc_objectsAtIndexes:)
         classMethod:NO];
}

/// @[] 字面量初始化数组
/// @param objects 数组
/// @param cnt 数组个数
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArray0 objectAtIndex:]: index 12 beyond bounds for empty NSArray'
- (instancetype)yxc_NSPlaceholderArray_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    
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
            arr[index++] = objects[i];
        }
    }
    
    return [self yxc_NSPlaceholderArray_initWithObjects:arr count:count];
}

/// 根据某个索引获取到数组元素
/// 当数组为空数组时，数组的类型为 __NSArray0，内部重新实现了 objectAtIndex: 方法，使用该方法对系统方法进行 hook
/// @param index 索引
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArray0 objectAtIndex:]: index 12 beyond bounds for empty NSArray'
- (id)yxc_NSArray0_objectAtIndex:(NSUInteger)index {
    
    // 判断当前数组是否为空数组
    if (self.count <= 0) return nil;
    
    if (index >= self.count) {
        index = self.count - 1;
    }
    
    return [self yxc_NSArray0_objectAtIndex:index];
}

/// 根据某个索引获取到数组元素
/// 当数组元素为 1 个时，数组的类型为 __NSSingleObjectArrayI，内部重新实现了 objectAtIndex: 方法，使用该方法对系统方法进行 hook
/// @param index 索引
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSSingleObjectArrayI objectAtIndex:]: index 12 beyond bounds [0 .. 0]'
- (id)yxc_NSSingleObjectArrayI_objectAtIndex:(NSUInteger)index {
    
    // 判断当前数组是否为空数组
    if (self.count <= 0) return nil;
    
    if (index >= self.count) {
        index = self.count - 1;
    }
    
    return [self yxc_NSSingleObjectArrayI_objectAtIndex:index];
}

/// 根据某个索引获取到数组元素，此处是使用字面量([]) 的方式获取
/// 当数组元素为多个时，数组的类型为 __NSArrayI，内部重新实现了 objectAtIndex: 方法，使用该方法对系统方法进行 hook
/// @param idx 索引
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayI objectAtIndexedSubscript:]: index 12 beyond bounds [0 .. 1]'
- (id)yxc_NSArrayI_objectAtIndexedSubscript:(NSUInteger)idx {
    
    if (self.count <= 0) return nil;
    
    if (idx >= self.count) {
        idx = self.count - 1;
    }
    
    return [self yxc_NSArrayI_objectAtIndexedSubscript:idx];
}

/// 根据索引获取数组某个元素（数组元素为多个），使用 objectAtIndex: 方法的方式获取
/// @param index 索引
- (id)yxc_NSArrayI_objectAtIndex:(NSUInteger)index {
    
    if (self.count <= 0) return nil;
    
    if (index >= self.count) {
        index = self.count - 1;
    }
    
    return [self yxc_NSArrayI_objectAtIndex:index];
}

/// 不可变数组，根据某个对象和范围获取索引值，在这不区分 __NSArray0、__NSSingleObjectArrayI、__NSArrayI 类型
/// 1. 当数组为空时
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSArray indexOfObject:inRange:]: range {0, 120} extends beyond bounds for empty array'
/// 2. 当数组不为空时
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSArray indexOfObject:inRange:]: range {0, 120} extends beyond bounds [0 .. 0]'
/// @param anObject 搜索的对象
/// @param range 搜索范围
- (NSUInteger)yxc_indexOfObject:(id)anObject inRange:(NSRange)range {
    
    // 判断搜索范围是否在数组界线
    if (range.location > (NSUInteger)self.count ||
        range.length > ((NSUInteger)self.count - range.location)) {
        return NSNotFound;
    }
    
    return [self yxc_indexOfObject:anObject inRange:range];
}


/// 不可变数组，根据 indexSet 获取某个元素
/// 1. 当数组为空时
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSArray objectsAtIndexes:]: index 14 in index set beyond bounds for empty array'
/// 2. 当数组不为空时
/// *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSArray objectsAtIndexes:]: index 14 in index set beyond bounds [0 .. 0]'
/// @param indexes 搜索范围
- (NSArray *)yxc_objectsAtIndexes:(NSIndexSet *)indexes {
    
    if (self.count <= 0) return nil;
    
    // 判断搜索范围是否在数组界线
    NSRange range = NSMakeRange(indexes.firstIndex, indexes.count);
    // range.location 大于数组元素个数，直接返回 nil
    if (range.location > (NSUInteger)self.count) return nil;
    
    // range.length 大于 数组元素个数 - range.location，直接取 range.location 开始，到数组的最后一个元素
    if (range.length > ((NSUInteger)self.count - range.location)) {
        range.length = self.count - range.location;
        indexes = [NSIndexSet indexSetWithIndexesInRange:range];
    }
    
    return [self yxc_objectsAtIndexes:indexes];
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
