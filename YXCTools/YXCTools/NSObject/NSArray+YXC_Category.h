//
//  NSArray+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (YXC_Category)

/// 通过函数式编程,将数组的每个元素,进行拼接
- (NSString *(^)(NSString *separator))yxc_joinedByString;

/// 通过链式编程,添加另外一个数组
- (NSArray *(^)(NSArray *array))yxc_addObjects;

@end

NS_ASSUME_NONNULL_END
