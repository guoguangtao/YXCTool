//
//  NSMutableAttributedString+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2021/4/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (YXC_Category)

/// 属性字符串拼接字符串
- (NSMutableAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> * _Nullable attributes))yxc_appendString;

/// 属性字符串拼接属性字符串
- (NSMutableAttributedString *(^)(NSAttributedString * _Nullable attributedString))yxc_appendAttributedString;

/// 属性字符串根据某个字符串修改属性
- (NSMutableAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> *_Nullable attributes))yxc_modifyAttributedString;

/// 给整个属性字符串增加属性
- (NSMutableAttributedString *(^)(NSDictionary<NSAttributedStringKey, id> * _Nullable attributes))yxc_addAttributed;

@end

NS_ASSUME_NONNULL_END
