//
//  NSDate+YXC_Category.m
//  YXCTools
//
//  Created by GGT on 2020/10/12.
//  Copyright © 2020 GGT. All rights reserved.
//

#import "NSDate+YXC_Category.h"

@implementation NSDate (YXC_Category)

/// 根据时间戳和当前的区域转换成字符串
/// @param timeInterval 时间戳(毫秒)
+ (NSString *)yxc_stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval {
    
    return [self yxc_stringWithTimeIntervalSince1970:timeInterval
                                          dateFormat:nil];
}

/// 根据时间戳和当前的区域转换成字符串
/// @param timeInterval 时间戳(毫秒)
/// @param dateFormat 时间格式
+ (NSString *)yxc_stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval
                                       dateFormat:(nullable NSString *)dateFormat {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval / 1000];
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = [self dateFormatter:dateFormat];
    
    return [dateFormatter stringFromDate:date];
}

/// 根据日期转成字符串
/// @param date 日期
+ (NSString *)yxc_stringWithDate:(NSDate *)date {
    
    return [self yxc_stringWithDate:date dateFormat:nil];
}

/// 根据日期转成字符串
/// @param date 日期
/// @param dateFormat 时间格式
+ (NSString *)yxc_stringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = [self dateFormatter:dateFormat];
    
    return [dateFormatter stringFromDate:date];
}

/// 根据时间字符串转成 NSDate
/// @param dateString 时间字符串
+ (NSDate *)yxc_dateWithDateString:(NSString *)dateString {
    
    return [self yxc_dateWithDateString:dateString dateFormat:nil];
}

/// 根据时间字符串转成 NSDate
/// @param dateString 时间字符串
/// @param dateFormat  时间格式
+ (NSDate *)yxc_dateWithDateString:(NSString *)dateString
                        dateFormat:(nullable NSString *)dateFormat {
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.dateFormat = [self dateFormatter:dateFormat];
    return [dateFormatter dateFromString:dateString];
}

/// 根据时间字符串转成时间戳(单位毫秒)
/// @param dateString 时间字符串
+ (NSTimeInterval)yxc_timeIntervalWithDateString:(NSString *)dateString {
    
    return  [self yxc_timeIntervalWithDateString:dateString dateFormat:nil];
}

/// 根据时间字符串转成时间戳(单位毫秒)
/// @param dateString 时间字符串
/// @param dateFormat 时间格式
+ (NSTimeInterval)yxc_timeIntervalWithDateString:(NSString *)dateString
                                      dateFormat:(nullable NSString *)dateFormat {
    
    NSDate *date = [NSDate yxc_dateWithDateString:dateString dateFormat:dateFormat];
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    
    return timeInterval * 1000;
}

/// 根据日期转成时间戳(单位毫秒)
/// @param date 日期
+ (NSTimeInterval)yxc_timeIntervalWithDate:(NSDate *)date {
    
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    
    return timeInterval * 1000;
}


/// 时间格式判断,传入的时间格式为 nil , 默认 yyyy-MM-dd HH:mm:ss 格式
/// @param dateFormatterStr 时间格式
+ (NSString *)dateFormatter:(NSString *)dateFormatterStr {
    
    NSString *dateFormatterString = @"yyyy-MM-dd HH:mm:ss";
    if (dateFormatterStr &&
        [dateFormatterStr isKindOfClass:[NSString class]] &&
        dateFormatterStr.length) {
        dateFormatterString = dateFormatterStr;
    }
    
    return dateFormatterString;;
}

@end

