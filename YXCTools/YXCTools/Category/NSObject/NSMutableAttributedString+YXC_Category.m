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

- (NSMutableAttributedString * _Nonnull (^)(UIImage * _Nonnull, UIFont * _Nonnull))yxc_addImageAttributedAndFont {
    
    return ^(UIImage *image, UIFont *font) {
        if (image == nil) return self;
        
        NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
        attachment.image = image;
        CGSize imageSize = image.size;
        CGFloat imageHeight = font.pointSize;
        CGFloat imageWidth = imageSize.width / imageSize.height * imageHeight;
        CGFloat paddingTop = (font.lineHeight - font.pointSize) * 0.5f;
        attachment.bounds = CGRectMake(0, -paddingTop, imageWidth, imageHeight);
        NSAttributedString *imageAtt = [NSAttributedString attributedStringWithAttachment:attachment];
        self.yxc_appendAttributedString(imageAtt);
        
        return self;
    };
}

- (NSMutableAttributedString * _Nonnull (^)(UIImage * _Nonnull, CGFloat))yxc_addImageAttributedAndFontSize {
    
    return ^(UIImage *image, CGFloat fontSize) {
        return self.yxc_addImageAttributedAndFont(image, [UIFont systemFontOfSize:fontSize]);
    };
}

- (NSMutableAttributedString * _Nonnull (^)(NSString * _Nonnull, UIFont * _Nonnull))yxc_addImageAttributedWithNameAndFont {
    
    return ^(NSString *imageName, UIFont *font) {
        
        if (imageName == nil || ![imageName isKindOfClass:[NSString class]] || !imageName.length) {
            return self;
        }
        return self.yxc_addImageAttributedAndFont([UIImage imageNamed:imageName], font);
    };
}

- (NSMutableAttributedString * _Nonnull (^)(NSString * _Nonnull, CGFloat))yxc_addImageAttributedWithNameAndFontSize {
    
    return ^(NSString *imageName, CGFloat fontSize) {
        
        return self.yxc_addImageAttributedWithNameAndFont(imageName, [UIFont systemFontOfSize:fontSize]);
    };
}

@end
