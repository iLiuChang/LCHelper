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

@property (nonatomic, readonly) NSInteger year;
@property (nonatomic, readonly) NSInteger month; //(1~12)
@property (nonatomic, readonly) NSInteger day; //(1~31)
@property (nonatomic, readonly) NSInteger hour; //(0~23)
@property (nonatomic, readonly) NSInteger minute; //(0~59)
@property (nonatomic, readonly) NSInteger second; //(0~59)
@property (nonatomic, readonly) NSInteger nanosecond;
@property (nonatomic, readonly) NSInteger weekday; //(1~7)
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
@property (nonatomic, readonly) NSInteger weekOfMonth; //(1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; //(1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
@property (nonatomic, readonly) BOOL isLeapMonth; 
@property (nonatomic, readonly) BOOL isLeapYear;
@property (nonatomic, readonly) BOOL isToday;
@property (nonatomic, readonly) BOOL isYesterday;

//---------------------------------------------------------
// 增加xx后的日期
- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;
//----------------------------------------------------------

/**
 
 @example: "yyyy-MM-dd HH:mm:ss"
 */
- (nullable NSString *)stringWithFormat:(NSString *)format;

/**
 
 根据时区和地点
 */
- (nullable NSString *)stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

/**
 国际标准时间
 @example: "2010-07-09T16:13:30+12:00"
 */
- (nullable NSString *)stringWithISOFormat;

/**
 
 时间间隔
 */
+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

/**
 
 时间间隔
 */
+ (nullable NSDate *)dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

/**
 时间间隔
 @param dateString The date string in ISO8601 format. e.g. "2010-07-09T16:13:30+12:00"
 */
+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;

NS_ASSUME_NONNULL_END
@end
