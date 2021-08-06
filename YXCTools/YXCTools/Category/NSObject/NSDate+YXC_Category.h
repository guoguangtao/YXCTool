//
//  NSDate+YXC_Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/12.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YXC_Category)

/// 根据时间戳和当前的区域转换成字符串
/// @param timeInterval 时间戳(毫秒)
+ (NSString *)yxc_stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval;

/// 根据时间戳和当前的区域转换成字符串
/// @param timeInterval 时间戳(毫秒)
/// @param dateFormat 时间格式
+ (NSString *)yxc_stringWithTimeIntervalSince1970:(NSTimeInterval)timeInterval
                                     dateFormat:(nullable NSString *)dateFormat;

/// 将时间字符串转换成字符串
/// @param timeString 时间字符串
/// @param targetDataFormat 当前传入的时间字符串格式
+ (NSString *)yxc_stringWithTimeString:(NSString *)timeString
                      targetDateFormat:(nonnull NSString *)targetDataFormat;

/// 将时间字符串转换成字符串
/// @param timeString 时间字符串
/// @param targetDataFormat 当前传入的时间字符串格式
/// @param dateFormat 时间格式
+ (NSString *)yxc_stringWithTimeString:(NSString *)timeString
                      targetDateFormat:(nonnull NSString *)targetDataFormat
                            dateFormat:(nullable NSString *)dateFormat;

/// 根据日期转成字符串
/// @param date 日期
+ (NSString *)yxc_stringWithDate:(NSDate *)date;

/// 根据日期转成字符串
/// @param date 日期
/// @param dateFormat 时间格式
+ (NSString *)yxc_stringWithDate:(NSDate *)date
                      dateFormat:(nullable NSString *)dateFormat;

/// 根据时间字符串转成 NSDate
/// @param dateString 时间字符串
+ (NSDate *)yxc_dateWithDateString:(NSString *)dateString;

/// 根据时间字符串转成 NSDate
/// @param dateString 时间字符串
/// @param dateFormat 时间格式
+ (NSDate *)yxc_dateWithDateString:(NSString *)dateString
                        dateFormat:(nullable NSString *)dateFormat;

/// 根据时间字符串转成时间戳(单位毫秒)
/// @param dateString 时间字符串
+ (NSTimeInterval)yxc_timeIntervalWithDateString:(NSString *)dateString;

/// 根据时间字符串转成时间戳(单位毫秒)
/// @param dateString 时间字符串
/// @param dateFormat 时间格式
+ (NSTimeInterval)yxc_timeIntervalWithDateString:(NSString *)dateString
                                      dateFormat:(nullable NSString *)dateFormat;

/// 根据日期转成时间戳(单位毫秒)
/// @param date 日期
+ (NSTimeInterval)yxc_timeIntervalWithDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END
