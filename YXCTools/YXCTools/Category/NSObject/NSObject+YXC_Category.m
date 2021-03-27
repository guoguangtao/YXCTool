//
//  NSObject+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/14.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSObject+YXC_Category.h"
#import "YXCToolHeader.h"
#import <objc/runtime.h>

@implementation NSObject (YXC_Category)

/// hook 实例方法
/// @param targetCls 需要被 hook 的类
/// @param currentCls 自己的实现方法所在的类
/// @param targetSelector 目标方法
/// @param currentSelector 准备替换目标方法
+ (void)hookInstanceMethodWithTargetCls:(Class)targetCls
                             currentCls:(Class)currentCls
                         targetSelector:(SEL)targetSelector
                        currentSelector:(SEL)currentSelector {
    
    [self hookMethodWithTargetCls:targetCls
                       currentCls:currentCls
                   targetSelector:targetSelector
                  currentSelector:currentSelector
                    isClassMethod:NO];
}

/// hook 类方法
/// @param targetCls 需要被 hook 的类
/// @param currentCls 自己的实现方法所在的类
/// @param targetSelector 目标方法
/// @param currentSelector 准备替换目标方法
+ (void)hookClassMethodWithTargetCls:(Class)targetCls
                          currentCls:(Class)currentCls
                      targetSelector:(SEL)targetSelector
                     currentSelector:(SEL)currentSelector {
    
    [self hookMethodWithTargetCls:targetCls
                       currentCls:currentCls
                   targetSelector:targetSelector
                  currentSelector:currentSelector
                    isClassMethod:YES];
}

/// hook 方法
/// @param targetCls 需要被 hook 的类
/// @param currentCls 自己的实现方法所在的类
/// @param targetSelector 目标方法
/// @param currentSelector 准备替换目标方法
/// @param isClassMethod 是否是类方法
+ (void)hookMethodWithTargetCls:(Class)targetCls
                     currentCls:(Class)currentCls
                 targetSelector:(SEL)targetSelector
                currentSelector:(SEL)currentSelector
                  isClassMethod:(BOOL)isClassMethod {
    
    Method targetMethod, currentMethod;
    if (isClassMethod) {
        // 获取类方法
        targetMethod = class_getClassMethod(targetCls, targetSelector);
        currentMethod = class_getClassMethod(currentCls, currentSelector);
    } else {
        // 获取实例方法
        targetMethod = class_getInstanceMethod(targetCls, targetSelector);
        currentMethod = class_getInstanceMethod(currentCls, currentSelector);
    }
    
    // 如果当前需要 hook 的方法是一个类方法
    // 使用 object_getClass 获取元类对象
    Class addCls = isClassMethod ? object_getClass(targetCls) : targetCls;
    
    // cls 类传入需要被 hook 的类
    // name 传入需要被 hook 的方法，如果 cls 类本身有该方法，返回结果为 NO，如果没有返回结果为 YES 代表添加该方法成功
    // imp 传入当前我们自己的方法具体实现
    // types 传入 imp 参数的方法编码字符串
    // 这一步主要的目的两点：
    // 1. 判断目标类本身是否有目标方法
    // 2. 没有目标方法，给目标类本身添加一个目标方法，并且将自己的方法具体实现赋值给目标方法
    BOOL addMethodSuccess = class_addMethod(addCls,
                                            targetSelector,
                                            method_getImplementation(currentMethod),
                                            method_getTypeEncoding(currentMethod));
    
    if (addMethodSuccess) {
        // 添加成功，目标类本身并没有这个方法，接下来就要将我们自己方法的实现替换成目标方法的实现
        class_replaceMethod(addCls,
                            currentSelector,
                            method_getImplementation(targetMethod),
                            method_getTypeEncoding(targetMethod));
    } else {
        // 目标类本身就有这个方法，直接将方法的实现进行交换
        method_exchangeImplementations(targetMethod, currentMethod);
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

/// 查看两个类的某个同名方法的实现是否一致
/// @param originCls 父类
/// @param targetCls 当前类
/// @param selector 方法
+ (void)printfMethodOriginCls:(Class)originCls targetCls:(Class)targetCls selector:(SEL)selector {
    
//    Method originMethod = class_getInstanceMethod(originCls, selector);
//    Method targetMethod = class_getInstanceMethod(targetCls, selector);
//    
//    IMP originIMP = class_getMethodImplementation(originCls, selector);
//    IMP targetIMP = class_getMethodImplementation(targetCls, selector);
//    
//    BOOL isSame = originMethod == targetMethod && originIMP == targetIMP;
//    
//    NSString *string = @"不一致";
//    if (isSame) {
//        string = @"一致";
//    }
//    
//    YXCLog(@"%@  -- 方法 --- %@：{\n %@_method : %p, %@_IMP : %p\n %@_method : %p, %@_IMP : %p\n}", NSStringFromSelector(selector), string, originCls, originMethod, originCls, originIMP, targetCls, targetMethod, targetCls, targetIMP);
}

/// 查询一个类本身是否拥有某个方法
/// @param selector 方法选择器
/// @param isClassMethod 需要查询的方法是否是类方法
+ (void)printfMethodWithSelector:(SEL)selector isClassMethod:(BOOL)isClassMethod {
    
    Class cls = [self class];
    if (isClassMethod) {
        cls = object_getClass(cls);
    }
    while (cls) {
        unsigned int count;
        BOOL hasMethod = NO;
        Method *methodList = class_copyMethodList(cls, &count);
        for (int i = 0; i < count; i++) {
            Method m = methodList[i];
            // 选择器地址始终唯一，就算两个不同的类相同的方法名所对应的选择器地址
            if (selector == method_getName(m)) {
                hasMethod = YES;
                NSLog(@"%@ 查找到 %@，方法具体实现地址：%p", cls, NSStringFromSelector(selector), method_getImplementation(m));
                break;
            }
        }
        if (!hasMethod) {
            NSLog(@"%@ 未查找到 %@", cls, NSStringFromSelector(selector));
        }
        cls = [cls superclass];
        free(methodList);
    }
}


@end
