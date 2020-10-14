//
//  NSObject+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/14.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSObject+YXC_Category.h"
#import <objc/runtime.h>

@implementation NSObject (YXC_Category)

/// hook 方法
/// @param cls 类
/// @param originSelector 将要 hook 掉的方法
/// @param swizzledSelector 新的方法
+ (void)hookMethod:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector {
    
    Method origin_method = class_getInstanceMethod(cls, originSelector);
    Method swizzled_method = class_getInstanceMethod(cls, swizzledSelector);
    BOOL addSuccess = class_addMethod(cls,
                                      originSelector,
                                      method_getImplementation(swizzled_method),
                                      method_getTypeEncoding(swizzled_method));
    if (addSuccess) {
        class_replaceMethod(cls,
                            swizzledSelector,
                            method_getImplementation(origin_method),
                            method_getTypeEncoding(origin_method));
    } else {
        method_exchangeImplementations(origin_method, swizzled_method);
    }
}

@end
