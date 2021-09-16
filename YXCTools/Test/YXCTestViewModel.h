//
//  YXCTestViewModel.h
//  YXCTools
//
//  Created by lbkj on 2021/9/16.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YXCTestViewModel : NSObject

#pragma mark - Property


#pragma mark - Method

- (void)requestData:(dispatch_block_t)completion;

@end

NS_ASSUME_NONNULL_END
