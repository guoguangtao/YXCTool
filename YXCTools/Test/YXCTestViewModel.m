//
//  YXCTestViewModel.m
//  YXCTools
//
//  Created by lbkj on 2021/9/16.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCTestViewModel.h"

@implementation YXCTestViewModel


#pragma mark - Lifecycle

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

- (void)requestData:(dispatch_block_t)completion {
    
    if (completion) {
        completion();
    }
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
