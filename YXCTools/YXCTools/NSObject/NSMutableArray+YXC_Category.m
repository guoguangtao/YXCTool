//
//  NSMutableArray+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/11/7.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSMutableArray+YXC_Category.h"

@implementation NSMutableArray (YXC_Category)

+ (void)load {
    
    // 可变数组插入对象
    [self hookOriginClass:NSClassFromString(@"__NSArrayM")
             currentClass:[self class]
           originSelector:@selector(insertObject:atIndex:)
         swizzledSelector:@selector(yxc_NSArrayM_insertObject:atIndex:) classMethod:NO];
    
    // 可变数组 根据 indexSet 插入一些数据
    [self hookMethod:[self class]
      originSelector:@selector(insertObjects:atIndexes:)
    swizzledSelector:@selector(yxc_insertObjects:atIndexes:)
         classMethod:NO];
    
    // 可变数组根据索引移除某个元素
    [self hookOriginClass:NSClassFromString(@"__NSArrayM")
             currentClass:[self class]
           originSelector:@selector(removeObjectsInRange:)
         swizzledSelector:@selector(yxc_NSArrayM_removeObjectsInRange:)
              classMethod:NO];
    
    // 可变数组，在某个范围移除所有与元素 isEqual 相等的元素
    [self hookMethod:[self class]
      originSelector:@selector(removeObject:inRange:)
    swizzledSelector:@selector(yxc_removeObject:inRange:)
         classMethod:NO];
    
    // 可变数组，在某个范围移除所有与元素 地址相同的元素
    [self hookMethod:[self class]
      originSelector:@selector(removeObjectIdenticalTo:inRange:)
    swizzledSelector:@selector(yxc_removeObjectIdenticalTo:inRange:)
         classMethod:NO];
    
    // 可变数组，根据 indexSet 移除某些元素
    [self hookMethod:[self class]
      originSelector:@selector(removeObjectsAtIndexes:)
    swizzledSelector:@selector(yxc_removeObjectsAtIndexes:)
         classMethod:NO];
    
    // 可变数组，利用下标索引替换某个元素
    [self hookOriginClass:NSClassFromString(@"__NSArrayM")
             currentClass:[self class]
           originSelector:@selector(replaceObjectAtIndex:withObject:)
         swizzledSelector:@selector(yxc_NSArrayM_replaceObjectAtIndex:withObject:)
              classMethod:NO];
    
    // 可变数组，利用下标索引交换两个元素
    [self hookOriginClass:NSClassFromString(@"__NSArrayM")
             currentClass:[self class]
           originSelector:@selector(exchangeObjectAtIndex:withObjectAtIndex:)
         swizzledSelector:@selector(yxc_NSArrayM_exchangeObjectAtIndex:withObjectAtIndex:)
              classMethod:NO];
    
    // 可变数组，根据 indexSet 替换一些元素
    [self hookMethod:[self class]
      originSelector:@selector(replaceObjectsAtIndexes:withObjects:)
    swizzledSelector:@selector(yxc_replaceObjectsAtIndexes:withObjects:)
         classMethod:NO];
    
    // 可变数组根据 NSRange 替换一些元素
    [self hookMethod:[self class]
      originSelector:@selector(replaceObjectsInRange:withObjectsFromArray:)
    swizzledSelector:@selector(yxc_replaceObjectsInRange:withObjectsFromArray:)
         classMethod:NO];
}

/// 根据索引插入一个元素
/// @param anObject 需要插入的对象
/// @param index 需要插入的索引
- (void)yxc_NSArrayM_insertObject:(id)anObject atIndex:(NSUInteger)index {
    
    // *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM insertObject:atIndex:]: object cannot be nil'
    // 判断当前插入的对象是否为 nil，如果是直接结束当前操作
    if (anObject == nil) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM insertObject:atIndex:]: index * beyond bounds for empty array'
    if (index > self.count) {
        // 当 index 超出数组最大范围，取当前数组个数作为 index
        index = self.count;
    }
    
    [self yxc_NSArrayM_insertObject:anObject atIndex:index];
}

/// 根据 indexSet 插入一些数据
/// @param objects 需要插入的数据
/// @param indexes 范围
- (void)yxc_insertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes {
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray insertObjects:atIndexes:]: index 6 in index set beyond bounds for empty array'
    if (self.count <= 0) return;
    
    NSMutableIndexSet *indexSets = [NSMutableIndexSet indexSet];
    NSMutableArray *objectsArray = [NSMutableArray array];
    __block NSUInteger count  = 0;
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.count) {
            [indexSets addIndex:idx];
            [objectsArray addObject:objects[count++]];
        }
    }];
    
    if (indexSets.count <= 0 ||
        objectsArray.count <= 0 ||
        indexSets.count != objectsArray.count)
        return;
    
    [self yxc_insertObjects:objectsArray atIndexes:indexSets];
}

/// 移除某个范围的元素
/// @param range 范围
- (void)yxc_NSArrayM_removeObjectsInRange:(NSRange)range {
    
    // 判断搜索范围是否在数组界线
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM removeObjectsInRange:]: range {18446744073709551606, 1} extends beyond bounds [0 .. 1]'
    if (range.location > (NSUInteger)self.count ||
        range.length > ((NSUInteger)self.count - range.location)) {
        return;
    }
    
    [self yxc_NSArrayM_removeObjectsInRange:range];
}


/// 在某个范围内，移除某个元素
/// @param anObject 需要被移除的对象
/// @param range 需要被移除的某个范围内
- (void)yxc_removeObject:(id)anObject inRange:(NSRange)range {
    
    if (anObject == nil) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray removeObject:inRange:]: range {0, 300} extends beyond bounds for empty array'
    if (self.count <= 0) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray removeObject:inRange:]: range {0, 300} extends beyond bounds [0 .. 1]'
    if (range.location > (NSUInteger)self.count ||
        range.length > ((NSUInteger)self.count - range.location)) {
        return;
    }
    
    [self yxc_removeObject:anObject inRange:range];
}

/// 删除数组中某个范围内所有与 anObject 地址相同的元素
/// @param anObject 需要被删除的元素
/// @param range 需要删除某个范围内的元素
- (void)yxc_removeObjectIdenticalTo:(id)anObject inRange:(NSRange)range {
    
    if (anObject == nil) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray removeObjectIdenticalTo:inRange:]: range {200, 200} extends beyond bounds for empty array'
    if (self.count <= 0) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray removeObjectIdenticalTo:inRange:]: range {200, 200} extends beyond bounds [0 .. 1]'
    if (range.location > (NSUInteger)self.count ||
        range.length > ((NSUInteger)self.count - range.location)) {
        return;
    }
    
    [self yxc_removeObjectIdenticalTo:anObject inRange:range];
}

/// 根据 indexSet 移除一些元素
/// @param indexes 需要移除的范围
- (void)yxc_removeObjectsAtIndexes:(NSIndexSet *)indexes {
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray removeObjectsAtIndexes:]: index 6 in index set beyond bounds [0 .. 5]'
    if (self.count <= 0) return;
    
    NSMutableIndexSet *indexSets = [NSMutableIndexSet indexSet];
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.count) {
            [indexSets addIndex:idx];
        }
    }];
    
    if (indexSets.count <= 0) return;
    
    [self yxc_removeObjectsAtIndexes:indexSets];
}

/// 数组根据下标索引替换某个元素
/// @param index 索引
/// @param anObject 对象
- (void)yxc_NSArrayM_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    
    // *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: '*** -[__NSArrayM replaceObjectAtIndex:withObject:]: object cannot be nil'
    if (anObject == nil) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM replaceObjectAtIndex:withObject:]: index 200 beyond bounds for empty array'
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM replaceObjectAtIndex:withObject:]: index 200 beyond bounds [0 .. 1]'
    if (index >= self.count) return;
    
    [self yxc_NSArrayM_replaceObjectAtIndex:index withObject:anObject];
}

/// 可变数组，根据索引交换两个元素的位置
/// @param idx1 索引 1
/// @param idx2 索引 2
- (void)yxc_NSArrayM_exchangeObjectAtIndex:(NSUInteger)idx1 withObjectAtIndex:(NSUInteger)idx2 {
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM exchangeObjectAtIndex:withObjectAtIndex:]: index 10 beyond bounds for empty array'
    if (self.count <= 0) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[__NSArrayM exchangeObjectAtIndex:withObjectAtIndex:]: index 10 beyond bounds [0 .. 1]'
    if (idx1 >= self.count || idx2 >= self.count || idx1 == idx2) return;
    
    [self yxc_NSArrayM_exchangeObjectAtIndex:idx1 withObjectAtIndex:idx2];
}

/// 可变数组，根据 indexSet 替换一些元素
/// @param indexes 需要替换的下标
/// @param objects 需要替换的元素
- (void)yxc_replaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects {
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray replaceObjectsAtIndexes:withObjects:]: index 24 in index set beyond bounds for empty array'
    if (self.count <= 0 || indexes.count <= 0 || objects.count <= 0) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray replaceObjectsAtIndexes:withObjects:]: index 24 in index set beyond bounds [0 .. 5]'
    NSMutableIndexSet *indexSets = [NSMutableIndexSet indexSet];
    NSMutableArray *objectsArray = [NSMutableArray array];
    __block NSUInteger count  = 0;

    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx < self.count) {
            [indexSets addIndex:idx];
            [objectsArray addObject:objects[count++]];
        }
    }];

    if (indexSets.count <= 0 ||
        objectsArray.count <= 0 ||
        indexSets.count != objectsArray.count)
        return;
    
    [self yxc_replaceObjectsAtIndexes:indexes withObjects:objects];
}

/// 可变数组根据 NSRange 替换一些元素
/// @param range 替换范围
/// @param otherArray 替换的数据
- (void)yxc_replaceObjectsInRange:(NSRange)range withObjectsFromArray:(NSArray *)otherArray {
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray replaceObjectsInRange:withObjectsFromArray:]: range {0, 1000} extends beyond bounds for empty array'
    if (self.count <= 0 || otherArray.count <= 0) return;
    
    // *** Terminating app due to uncaught exception 'NSRangeException', reason: '*** -[NSMutableArray replaceObjectsInRange:withObjectsFromArray:]: range {0, 1000} extends beyond bounds [0 .. 0]'
    if (range.location > (NSUInteger)self.count ||
        range.length > ((NSUInteger)self.count - range.location)) {
        return;
    }
    
    [self yxc_replaceObjectsInRange:range withObjectsFromArray:otherArray];
}

@end
