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

/// hook 方法
/// @param cls 类
/// @param originSelector 将要 hook 掉的方法
/// @param swizzledSelector 新的方法
/// @param clsMethod 是否是类方法
+ (void)hookMethod:(Class)cls
    originSelector:(SEL)originSelector
  swizzledSelector:(SEL)swizzledSelector
       classMethod:(BOOL)clsMethod;

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
            classMethod:(BOOL)clsMethod;

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

/// 判断当前对象是否为nil
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
