//
//  YXCPerson.h
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCPerson : NSObject

#pragma mark - Property

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSInteger age;


#pragma mark - Method

//+ (instancetype)shareInstance;

@end

NS_ASSUME_NONNULL_END
