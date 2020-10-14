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
+ (void)hookMethod:(Class)cls
    originSelector:(SEL)originSelector
  swizzledSelector:(SEL)swizzledSelector;

@end

NS_ASSUME_NONNULL_END
