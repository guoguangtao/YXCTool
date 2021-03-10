//
//  NSAttributedString+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2021/3/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "NSAttributedString+YXC_Category.h"

@implementation NSAttributedString (YXC_Category)

/// 属性字符串拼接
- (NSAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> * _Nullable attributes))yxc_appendAttributedString {
    
    return ^(NSString *string, NSDictionary<NSAttributedStringKey, id> *attributes) {
        
        if (string == nil || ![string isKindOfClass:[NSString class]] || !string.length) {
            return self;
        }
        
        NSMutableAttributedString *mutableAttributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self];
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        [mutableAttributedString appendAttributedString:attributedString];
        
        return (NSAttributedString *)[mutableAttributedString copy];
    };
}

@end
