//
//  NSObject+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/14.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// NSObject 分类
@interface NSObject (YXC_Category)

#pragma mark - Method

/// hook 实例方法
/// @param targetCls 需要被 hook 的类
/// @param currentCls 自己的实现方法所在的类
/// @param targetSelector 目标方法
/// @param currentSelector 准备替换目标方法
+ (void)hookInstanceMethodWithTargetCls:(Class)targetCls
                             currentCls:(Class)currentCls
                         targetSelector:(SEL)targetSelector
                        currentSelector:(SEL)currentSelector;

/// hook 类方法
/// @param targetCls 需要被 hook 的类
/// @param currentCls 自己的实现方法所在的类
/// @param targetSelector 目标方法
/// @param currentSelector 准备替换目标方法
+ (void)hookClassMethodWithTargetCls:(Class)targetCls
                          currentCls:(Class)currentCls
                      targetSelector:(SEL)targetSelector
                     currentSelector:(SEL)currentSelector;

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
                  isClassMethod:(BOOL)isClassMethod;

/// 检查当前对象,YES-满足条件 NO-不满足条件
/// 是否为 nil
/// 是否为 数组
/// 数组长度是否大于 0
- (BOOL)checkArray;

/// 检查当前对象,YES-满足条件 NO-不满足条件
/// 是否为 nil
/// 是否为 字符串
/// 长度是否大于 0
/// 字符串是否包含 null 或者 NULL
- (BOOL)checkString;

/// 检查当前对象,YES-满足条件 NO-不满足条件
/// 是否为 nil
/// 是否为 字典类型
- (BOOL)checkDictionary;

/// 查看两个类的某个同名方法的实现是否一致
/// @param originCls 父类
/// @param targetCls 当前类
/// @param selector 方法
+ (void)printfMethodOriginCls:(Class)originCls targetCls:(Class)targetCls selector:(SEL)selector;

/// 查询一个类本身是否拥有某个方法
/// @param selector 方法选择器
/// @param isClassMethod 需要查询的方法是否是类方法
+ (void)printfMethodWithSelector:(SEL)selector isClassMethod:(BOOL)isClassMethod;

/// 打印一个类的所有属性
- (void)printfAllProperty;

/// 打印一个类的所有成员变量
- (void)printfAllVar;

/// 打印一个类的所有方法
- (void)printfAllMethod;

@end

NS_ASSUME_NONNULL_END
