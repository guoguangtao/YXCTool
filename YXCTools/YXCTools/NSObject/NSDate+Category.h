//
//  NSDate+Category.h
//  YXCTools
//
//  Created by GGT on 2020/10/12.
//  Copyright © 2020 GGT. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (Category)

/// 根据时间戳和当前的区域转换成 NSDate
/// @param timeInterval 时间戳(毫秒)
+ (NSString *)yxc_dateWithTimeIntervalSince1970:(NSTimeInterval)timeInterval;

/// 根据时间戳和当前的区域转换成 NSDate
/// @param timeInterval 时间戳(毫秒)
/// @param dateForMatter 时间格式
+ (NSString *)yxc_dateWithTimeIntervalSince1970:(NSTimeInterval)timeInterval
                                  dateFormatter:(NSString *)dateForMatter;

@end

NS_ASSUME_NONNULL_END
