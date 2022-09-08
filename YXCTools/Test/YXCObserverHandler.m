//
//  YXCObserverHandler.m
//  YXCTools
//
//  Created by lbkj on 2021/9/17.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCObserverHandler.h"

@implementation YXCObserverHandler


#pragma mark - Lifecycle

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public


#pragma mark - Private

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"Person外部监听name:%@", change[NSKeyValueChangeNewKey]);
}



#pragma mark - Protocol


#pragma mark - Lazy


@end
