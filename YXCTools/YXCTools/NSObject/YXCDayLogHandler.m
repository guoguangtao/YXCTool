//
//  YXCDayLogHandler.m
//  YXCTools
//
//  Created by lbkj on 2021/11/10.
//  Copyright © 2021 GGT. All rights reserved.
//

#import "YXCDayLogHandler.h"

@implementation YXCDayLogHandler


#pragma mark - Lifecycle

- (void)dealloc {
    
    
}


#pragma mark - Custom Accessors (Setter 方法)


#pragma mark - Public

+ (void)redirectLEBLogToDocumentFolder {
    NSString *documentDirectory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
    NSString *fileName = [NSString stringWithFormat:@"Log-%@.txt",[dateformat stringFromDate:[NSDate date]]];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    [defaultManager removeItemAtPath:logFilePath error:nil];
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end