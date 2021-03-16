//
//  NSAttributedString+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2021/3/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (YXC_Category)

/// 属性字符串拼接字符串
- (NSAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> * _Nullable attributes))yxc_appendString;

/// 属性字符串拼接属性字符串
- (NSAttributedString *(^)(NSAttributedString * _Nullable attributedString))yxc_appendAttributedString;

@end

NS_ASSUME_NONNULL_END