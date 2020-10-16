//
//  NSDictionary+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/4/17.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSDictionary+YXC_Category.h"
#import <objc/runtime.h>

@implementation NSDictionary (YXC_Category)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 获取系统 initWithObjects:forKeys:count: 方法，这里是获取一个实例方法利用 class_getInstanceMethod 去获取
        // class_getInstanceMethod(Class _Nullable cls, SEL _Nonnull name) 这里 cls 是所需要替换方法的类， name 是需要替换方法的 SEL
        Method system_initWithObjectsForKeysCountMethod = class_getInstanceMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:));
        // 拿到自己所写的 yxc_initWithObjects:forKeys:count:
        Method yxc_initWithObjectsForKeysCountMethod = class_getInstanceMethod(self, @selector(yxc_initWithObjects:forKeys:count:));
        // 将系统方法和自己所写的方法进行替换
        // method_exchangeImplementations(Method _Nonnull m1, Method _Nonnull m2) 需要替换的方法
        method_exchangeImplementations(system_initWithObjectsForKeysCountMethod, yxc_initWithObjectsForKeysCountMethod);
        
        Method system_setObjectForKeyMethod = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:));
        Method yxc_setObjectForKeyMethod = class_getInstanceMethod(self, @selector(yxc_setObject:forKey:));
        method_exchangeImplementations(system_setObjectForKeyMethod, yxc_setObjectForKeyMethod);
        
        Method system_setValueForKeyMethod = class_getInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setValue:forKey:));
        Method yxc_setValueForKeyMethod = class_getInstanceMethod(self, @selector(yxc_setValue:forKey:));
        method_exchangeImplementations(system_setValueForKeyMethod, yxc_setValueForKeyMethod);
    });
    
}

- (instancetype)yxc_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    
    // 此处因为传入的参数是 C 语言数组，所以这里也通过 C 语言数组操作
    NSUInteger index = 0; // 数组下标，用于将数据存入正确的位置
    id objectsArray[cnt]; // 值 数组
    id<NSCopying> keysArray[cnt]; // 键 数组
    
    // 遍历传入的参数数组，对正常的数据放入新创建的数组中
    for (int i = 0; i < cnt; i++) {
        if (objects[i] != nil && keys[i] != nil) {
            objectsArray[index] = objects[i];
            keysArray[index] = keys[i];
            index++;
        }
    }
    
    // 调用系统方法，这里一定是 yxc_initWithObjects:forKeys:count: 方法，因为已经方法替换了，调用这个方法实际上是调用系统原来的方法
    // 将处理好的健值数组作为新的健值数组传入
    return [self yxc_initWithObjects:objectsArray forKeys:keysArray count:index];
}

- (void)yxc_setObject:(id)anObject forKey:(id <NSCopying>)aKey {

    if (anObject != nil && aKey != nil) {
        [self yxc_setObject:anObject forKey:aKey];
    }
}

- (void)yxc_setValue:(id)value forKey:(NSString *)key {
    
    if (key != nil && ![key isKindOfClass:[NSNull class]]) {
        [self yxc_setValue:value forKey:key];
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    YXCLog(@"setValue:forUndefinedKey - %@ : %@", key, value);
}

- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

@end
