//
//  NSURL+YXCCategory.m
//  MacCommand
//
//  Created by guogt on 2023/5/8.
//

#import "NSURL+YXCCategory.h"
#import <objc/runtime.h>

@implementation NSURL (YXCCategory)

- (NSDictionary *)yxc_queryItemsDictionary {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    [self.yxc_components.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dictionary setValue:obj.value forKey:obj.name];
    }];

    return dictionary;
}

- (NSURLComponents *)yxc_components {

    NSURLComponents *components = objc_getAssociatedObject(self, @selector(yxc_components));

    if (components == nil) {
        components = [[NSURLComponents alloc] initWithString:self.absoluteString];
        objc_setAssociatedObject(self, @selector(yxc_components), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    return components;
}

@end
