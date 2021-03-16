//
//  NSMutableDictionary+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/11/7.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSMutableDictionary+YXC_Category.h"
#import "NSObject+YXC_Category.h"

@implementation NSMutableDictionary (YXC_Category)

+ (void)load {
    
    [self hookInstanceMethodWithTargetCls:NSClassFromString(@"__NSDictionaryM")
                               currentCls:[self class]
                           targetSelector:@selector(setObject:forKey:)
                          currentSelector:@selector(yxc_setObject:forKey:)];
    
    [self hookInstanceMethodWithTargetCls:NSClassFromString(@"__NSDictionaryM")
                               currentCls:[self class]
                           targetSelector:@selector(removeObjectForKey:)
                          currentSelector:@selector(yxc_NSDictionaryM_removeObjectForKey:)];
}

- (void)yxc_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    
    if (anObject == nil) return;
    if (aKey == nil) return;
    
    [self yxc_setObject:anObject forKey:aKey];
}

- (void)yxc_NSDictionaryM_removeObjectForKey:(id)aKey {
    
    if (aKey == nil) return;
    
    [self yxc_NSDictionaryM_removeObjectForKey:aKey];
}

@end
