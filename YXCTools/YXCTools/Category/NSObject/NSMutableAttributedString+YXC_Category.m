//
//  NSMutableAttributedString+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2021/4/13.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "NSMutableAttributedString+YXC_Category.h"

@implementation NSMutableAttributedString (YXC_Category)

/// 属性字符串拼接字符串
- (NSMutableAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> * _Nullable attributes))yxc_appendString {
    
    return ^(NSString *string, NSDictionary<NSAttributedStringKey, id> *attributes) {
        
        if (string == nil || ![string isKindOfClass:[NSString class]] || !string.length) {
            return self;
        }
        
        NSAttributedString *attributedString = [[NSAttributedString alloc] initWithString:string attributes:attributes];
        return self.yxc_appendAttributedString(attributedString);
    };
}

/// 属性字符串拼接属性字符串
- (NSMutableAttributedString * _Nonnull (^)(NSAttributedString * _Nullable))yxc_appendAttributedString {
    
    return ^(NSAttributedString *attributedString) {
        
        if (attributedString == nil || ![attributedString isKindOfClass:[NSAttributedString class]] || !attributedString.length) {
            return self;
        }
        
        [self appendAttributedString:attributedString];
        
        return self;
    };
}

/// 属性字符串根据某个字符串修改属性
- (NSMutableAttributedString *(^)(NSString * _Nullable string, NSDictionary<NSAttributedStringKey, id> *_Nullable attributes))yxc_modifyAttributedString {
    
    return ^(NSString *string, NSDictionary<NSAttributedStringKey, id> *attributes) {
        
        if (string == nil || ![string isKindOfClass:[NSString class]] || !string.length) {
            return self;
        }
        
        NSRange range = [self.string rangeOfString:string];
        if (range.location != NSNotFound && range.length > 0) {
            [self setAttributes:attributes range:range];
            return self;
        }
        
        return self;
    };
}

- (NSMutableAttributedString * _Nonnull (^)(NSDictionary<NSAttributedStringKey,id> * _Nullable))yxc_addAttributed {
    
    return ^(NSDictionary<NSAttributedStringKey, id> *attributeds) {
        
        [self addAttributes:attributeds range:NSMakeRange(0, self.length)];
        
        return self;
    };
}

@end
