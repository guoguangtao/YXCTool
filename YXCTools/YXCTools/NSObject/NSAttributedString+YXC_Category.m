//
//  NSAttributedString+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2021/3/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "NSAttributedString+YXC_Category.h"

@implementation NSAttributedString (YXC_Category)

/// 属性字符串拼接字符串
- (NSAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> * _Nullable attributes))yxc_appendString {
    
    return ^(NSString *string, NSDictionary<NSAttributedStringKey, id> *attributes) {
        
        if (string == nil || ![string isKindOfClass:[NSString class]] || !string.length) {
            return self;
        }
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        return self.yxc_appendAttributedString(attributedString);
    };
}

/// 属性字符串拼接属性字符串
- (NSAttributedString * _Nonnull (^)(NSAttributedString * _Nullable))yxc_appendAttributedString {
    
    return ^(NSAttributedString *attributedString) {
        
        if (attributedString == nil || ![attributedString isKindOfClass:[NSAttributedString class]] || !attributedString.length) {
            return self;
        }
        
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self];
        [mutableAttributedString appendAttributedString:attributedString];
        
        return (NSAttributedString *)[mutableAttributedString copy];
    };
}

@end
