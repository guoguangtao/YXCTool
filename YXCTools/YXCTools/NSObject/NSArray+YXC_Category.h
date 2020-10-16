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

- (NSString *(^)(NSString *separator))joinedByString;

@end

NS_ASSUME_NONNULL_END
