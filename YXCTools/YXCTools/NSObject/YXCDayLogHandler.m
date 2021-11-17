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
    documentDirectory = [documentDirectory stringByAppendingPathComponent:@"DayLogFile"];
    NSFileManager *defaultManager = [NSFileManager defaultManager];
    BOOL isDirectory = NO;
    BOOL existed = [defaultManager fileExistsAtPath:documentDirectory isDirectory:&isDirectory];
    if (!(isDirectory == YES && existed == YES)) {
        // 创建文件夹
        [defaultManager createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSDateFormatter *dateformat = [[NSDateFormatter  alloc]init];
    [dateformat setDateFormat:@"YYYY_MM_dd"];
    documentDirectory = [documentDirectory stringByAppendingPathComponent:[dateformat stringFromDate:[NSDate date]]];
    isDirectory = NO;
    existed = [defaultManager fileExistsAtPath:documentDirectory isDirectory:&isDirectory];
    if (!(isDirectory == YES && existed == YES)) {
        [defaultManager createDirectoryAtPath:documentDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }
    [dateformat setDateFormat:@"HH_mm_ss"];
    NSString *fileName = [NSString stringWithFormat:@"%@.txt",[dateformat stringFromDate:[NSDate date]]];
    NSString *logFilePath = [documentDirectory stringByAppendingPathComponent:fileName];
    // 先删除已经存在的文件
    [defaultManager removeItemAtPath:logFilePath error:nil];
    // 将log输入到文件
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stdout);
    freopen([logFilePath cStringUsingEncoding:NSASCIIStringEncoding], "a+", stderr);
}


#pragma mark - Private


#pragma mark - Protocol


#pragma mark - Lazy


@end
