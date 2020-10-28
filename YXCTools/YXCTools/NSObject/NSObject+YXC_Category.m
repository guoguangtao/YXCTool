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
/// @param clsMethod 类方法
+ (void)hookMethod:(Class)cls originSelector:(SEL)originSelector swizzledSelector:(SEL)swizzledSelector classMethod:(BOOL)clsMethod {
    
    [self hookOriginClass:cls
             currentClass:cls
           originSelector:originSelector
         swizzledSelector:swizzledSelector
              classMethod:clsMethod];
}

/// hook 方法 （主要是为了 hook 某个类的 簇类 方法）
/// @param originCls 需要 hook 的类
/// @param currentCls 当前类
/// @param originSelector 将要 hook 掉的方法
/// @param swizzledSelector 新的方法
/// @param clsMethod 是否是类方法
+ (void)hookOriginClass:(Class)originCls
           currentClass:(Class)currentCls
         originSelector:(SEL)originSelector
       swizzledSelector:(SEL)swizzledSelector
            classMethod:(BOOL)clsMethod {
    
    Method origin_method;
    Method swizzled_method;
    
    if (clsMethod) {
        // 类方法
        origin_method = class_getClassMethod(originCls, originSelector);
        swizzled_method = class_getClassMethod(currentCls, swizzledSelector);
    } else {
        // 实例(对象)方法
        origin_method = class_getInstanceMethod(originCls, originSelector);
        swizzled_method = class_getInstanceMethod(currentCls, swizzledSelector);
    }
    
    // 给当前类添加 originSelector 方法，方法实现为 swizzled_method
    // 如果传入的是一个类方法，在这里需要将 元类对象传进去
    Class addCls = clsMethod ? object_getClass(currentCls) : currentCls;
    
    BOOL isResponds = [addCls respondsToSelector:originSelector];
    YXCLog(@"%@对象%@响应%@", clsMethod ? @"元类" : @"类", isResponds ? @"能" : @"不能", NSStringFromSelector(originSelector));
    
    BOOL addSuccess = class_addMethod(addCls,
                                      originSelector,
                                      method_getImplementation(swizzled_method),
                                      method_getTypeEncoding(swizzled_method)
                                      );
    
    YXCLog(@"添加%@%@", NSStringFromSelector(originSelector), addSuccess ? @"成功" : @"失败");
    
    if (addSuccess) {
        // 将当前类的 swizzledSelector 的实现替换成 origin_method
        class_replaceMethod(addCls,
                            swizzledSelector,
                            method_getImplementation(origin_method),
                            method_getTypeEncoding(origin_method)
                            );
    } else {
        method_exchangeImplementations(origin_method, swizzled_method);
    }
}

/// 检查当前对象,YES-满足条件 NO-不满足条件
/// 是否为 nil
/// 是否为 数组
/// 数组长度是否大于 0
- (BOOL)checkArray {
    
    if (!self || ![self isKindOfClass:[NSArray class]]) return NO;
    
    NSArray *array = (NSArray *)self;
    
    return array.count;
}

/// 检查当前对象,YES-满足条件 NO-不满足条件
/// 是否为 nil
/// 是否为 字符串
/// 长度是否大于 0
/// 字符串是否包含 null 或者 NULL
- (BOOL)checkString {
    
    if (!self || ![self isKindOfClass:[NSString class]]) return NO;
    
    NSString *string = (NSString *)self;
    
    if (!string.length) return NO;
    
    return ![string.lowercaseString containsString:@"null"];
}

/// 检查当前对象,YES-满足条件 NO-不满足条件
/// 是否为 nil
/// 是否为 字典类型
- (BOOL)checkDictionary {
    
    if (!self || ![self isKindOfClass:[NSDictionary class]]) return NO;
    
    return YES;
}

/// 判断当前对象是否为nil
- (BOOL)isEmpty {
    
    return self;
}

@end
