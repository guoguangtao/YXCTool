//
//  YXCDayLogHandler.h
//  YXCTools
//
//  Created by lbkj on 2021/11/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 日志保存
@interface YXCDayLogHandler : NSObject

#pragma mark - Property


#pragma mark - Method

/// 日志保存
+ (void)redirectLEBLogToDocumentFolder;

@end

NS_ASSUME_NONNULL_END
