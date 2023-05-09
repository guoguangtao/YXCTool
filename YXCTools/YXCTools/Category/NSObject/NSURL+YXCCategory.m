//
//  NSURL+YXCCategory.m
//  MacCommand
//
//  Created by guogt on 2023/5/8.
//

#import "NSURL+YXCCategory.h"
#import <objc/runtime.h>

@implementation NSURL (YXCCategory)

- (NSString *)scheme {

    return self.components.scheme;
}

- (NSString *)user {

    return self.components.user;
}

- (NSString *)password {

    return self.components.password;
}

- (NSString *)host {

    return self.components.host;
}

- (NSNumber *)port {

    return self.components.port;
}

- (NSString *)path {

    return self.components.path;
}

- (NSString *)query {

    return self.components.query;
}

- (NSArray<NSURLQueryItem *> *)queryItems {

    return self.components.queryItems;
}

- (NSDictionary *)queryItemsDictionary {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    [self.queryItems enumerateObjectsUsingBlock:^(NSURLQueryItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dictionary setValue:obj.value forKey:obj.name];
    }];
    
    return dictionary;
}

- (NSURLComponents *)components {
    
    NSURLComponents *components = objc_getAssociatedObject(self, @selector(components));
    
    if (components == nil) {
        components = [[NSURLComponents alloc] initWithString:self.absoluteString];
        objc_setAssociatedObject(self, @selector(components), components, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return components;
}

@end
