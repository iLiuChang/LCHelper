//
//  NSDate+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LCHelp)
NS_ASSUME_NONNULL_BEGIN

@property (nonatomic, readonly) NSInteger lc_year;
@property (nonatomic, readonly) NSInteger lc_month; //(1~12)
@property (nonatomic, readonly) NSInteger lc_day; //(1~31)
@property (nonatomic, readonly) NSInteger lc_hour; //(0~23)
@property (nonatomic, readonly) NSInteger lc_minute; //(0~59)
@property (nonatomic, readonly) NSInteger lc_second; //(0~59)
@property (nonatomic, readonly) NSInteger lc_nanosecond;
@property (nonatomic, readonly) NSInteger lc_weekday; //(1~7)
@property (nonatomic, readonly) NSInteger lc_weekdayOrdinal;
@property (nonatomic, readonly) NSInteger lc_weekOfMonth; //(1~5)
@property (nonatomic, readonly) NSInteger lc_weekOfYear; //(1~53)
@property (nonatomic, readonly) NSInteger lc_yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger lc_quarter;
@property (nonatomic, readonly) BOOL lc_isLeapMonth;
@property (nonatomic, readonly) BOOL lc_isLeapYear;
@property (nonatomic, readonly) BOOL lc_isToday;
@property (nonatomic, readonly) BOOL lc_isYesterday;

- (nullable NSDate *)lc_addYears:(NSInteger)years;
- (nullable NSDate *)lc_addMonths:(NSInteger)months;
- (nullable NSDate *)lc_addWeeks:(NSInteger)weeks;
- (nullable NSDate *)lc_addDays:(NSInteger)days;
- (nullable NSDate *)lc_addHours:(NSInteger)hours;
- (nullable NSDate *)lc_addMinutes:(NSInteger)minutes;
- (nullable NSDate *)lc_addSeconds:(NSInteger)seconds;

/**
 
 @example: "yyyy-MM-dd HH:mm:ss"
 */
- (nullable NSString *)lc_stringWithFormat:(NSString *)format;

/**
 
 根据时区和地点
 */
- (nullable NSString *)lc_stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

/**
 国际标准时间
 @example: "2010-07-09T16:13:30+12:00"
 */
- (nullable NSString *)lc_stringWithISOFormat;

/**
 
 时间间隔
 */
+ (nullable NSDate *)lc_dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 
 时间间隔
 */
+ (nullable NSDate *)lc_dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

/**
 时间间隔
 @param dateString The date string in ISO8601 format. e.g. "2010-07-09T16:13:30+12:00"
 */
+ (nullable NSDate *)lc_dateWithISOFormatString:(NSString *)dateString;

NS_ASSUME_NONNULL_END
@end
