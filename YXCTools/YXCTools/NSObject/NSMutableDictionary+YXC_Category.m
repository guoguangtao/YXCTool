//
//  NSMutableDictionary+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/11/7.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSMutableDictionary+YXC_Category.h"

@implementation NSMutableDictionary (YXC_Category)

+ (void)load {
    
    [self hookOriginClass:NSClassFromString(@"__NSDictionaryM")
             currentClass:[self class]
           originSelector:@selector(setObject:forKey:)
         swizzledSelector:@selector(yxc_setObject:forKey:)
              classMethod:NO];
    
    [self hookOriginClass:NSClassFromString(@"__NSDictionaryM")
             currentClass:[self class]
           originSelector:@selector(removeObjectForKey:)
         swizzledSelector:@selector(yxc_NSDictionaryM_removeObjectForKey:)
              classMethod:NO];
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
