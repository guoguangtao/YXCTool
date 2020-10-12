//
//  NSDate+Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/12.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSDate+Category.h"

@implementation NSDate (Category)

/// 根据时间戳和当前的区域转换成 NSDate
/// @param timeInterval 时间戳(毫秒)
+ (NSString *)yxc_dateWithTimeIntervalSince1970:(NSTimeInterval)timeInterval {
    
    return [self yxc_dateWithTimeIntervalSince1970:timeInterval
                                     dateFormatter:@"yyyy-MM-dd HH:mm:ss"];
}

/// 根据时间戳和当前的区域转换成 NSDate
/// @param timeInterval 时间戳(毫秒)
/// @param dateForMatter 时间格式
+ (NSString *)yxc_dateWithTimeIntervalSince1970:(NSTimeInterval)timeInterval
                                  dateFormatter:(NSString *)dateForMatter {
    
    NSString *dateFormatterString = @"yyyy-MM-dd HH:mm:ss";
    if (dateForMatter &&
        [dateForMatter isKindOfClass:[NSString class]] &&
        dateForMatter.length) {
        dateFormatterString = dateForMatter;
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = dateFormatterString;
    
    return [dateFormatter stringFromDate:date];
}

@end

