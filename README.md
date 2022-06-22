

# LCHelper

Some categories in Objective-C.

## Requirements

- **iOS 8.0+**

## Usage

### UIKit

- **UIView+LCHelp**

```objective-c
@property(nonatomic, assign) CGFloat lc_left;
@property(nonatomic, assign) CGFloat lc_top;
@property(nonatomic, assign) CGFloat lc_right;
@property(nonatomic, assign) CGFloat lc_bottom;
@property(nonatomic, assign) CGFloat lc_width;
@property(nonatomic, assign) CGFloat lc_height;
@property(nonatomic, assign) CGFloat lc_centerX;
@property(nonatomic, assign) CGFloat lc_centerY;
@property(nonatomic, assign) CGPoint lc_origin;
@property(nonatomic, assign) CGSize lc_size;

// 链式编程
- (UIView *(^)(CGFloat top))lc__top;
- (UIView *(^)(CGFloat bottom))lc__bottom;
- (UIView *(^)(CGFloat offset))lc__bottomOffset;
- (UIView *(^)(CGFloat left))lc__left;
- (UIView *(^)(CGFloat right))lc__right;
- (UIView *(^)(CGFloat offset))lc__rightOffset;
- (UIView *(^)(CGFloat width))lc__width;
- (UIView *(^)(CGFloat offset))lc__flexToRightOffset; // width
- (UIView *(^)(CGFloat height))lc__height;
- (UIView *(^)(CGFloat offset))lc__flexToBottomOffset; // height
- (UIView *(^)(CGFloat x))lc__centerX;
- (UIView *(^)(CGFloat y))lc__centerY;
- (UIView *(^)(void))lc__center;
- (UIView *(^)(CGSize size))lc__size;
- (UIView *(^)(CGPoint origin))lc__origin;
- (UIView *(^)(CGFloat w, CGFloat h))lc__sizeToFitLessThan;
```

- **UIColor+LCHelp**

```objective-c
+ (UIColor *)lc_colorWithHex:(NSString *)hexStr; // @"0xF0F", @"66ccff", @"#66CCFF88"
+ (UIColor *)lc_colorWithRGB:(uint32_t)rgbValue;
+ (UIColor *)lc_colorWithRGBA:(uint32_t)rgbaValue;
+ (UIColor *)lc_colorWithRGB:(uint32_t)rgbValue alpha:(CGFloat)alpha;
```

- **UIControl+LCHelp**

```objective-c
- (void)lc_addEventTouchUpInsideBlock:(void (^)(id sender))block;
- (void)lc_addEvents:(UIControlEvents)controlEvents invoke:(void (^)(id sender))block;
- (void)lc_setEvents:(UIControlEvents)controlEvents invoke:(void (^)(id sender))block;
- (void)lc_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;
- (void)lc_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;
- (void)lc_removeAllTargets;
```

- **UIImage+LCHelp**

```objective-c
/// Captures a new image with a given view.
+ (UIImage *)lc_imageWithCaptureView:(UIView *)view;

/// Returns a new image with a given color.
+ (UIImage *)lc_imageWithColor:(UIColor *)color;

/// Returns a new image with a given color.
+ (UIImage *)lc_imageWithColor:(UIColor *)color size:(CGSize)size;

/// Returns a round image.
- (UIImage *)lc_roundedImage;

/// Returns a round image with a given `borderWidth` and `borderColor`.
- (UIImage *)lc_roundedImageWithBorderWidth:(CGFloat)borderWidth borderColor:(nullable UIColor *)borderColor;

/// Returns a new image which is resized from this image. You can specify a larger or smaller size than the image size. The image content will be changed with the scale mode.
- (UIImage *)lc_resizedImageWithSize:(CGSize)size contentMode:(UIViewContentMode)contentMode;

/// Returns a new image which is cropped from this image.
- (UIImage *)lc_croppedImageWithRect:(CGRect)rect;

/// Rounds a new image with a given corner radius.
- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius;

/// Rounds a new image with a given corner radius and corners.
- (UIImage *)lc_roundedCornerImageWithRadius:(CGFloat)radius
                                     corners:(UIRectCorner)corners
                                 borderWidth:(CGFloat)borderWidth
                                 borderColor:(nullable UIColor *)borderColor;
```

- **UIBarButtonItem+LCHelp**

```objective-c
+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                                action:(SEL)action
                                 image:(nullable UIImage *)image
                             highImage:(nullable UIImage *)highImage;

+ (UIBarButtonItem *)lc_itemWithTarget:(id)target
                                action:(SEL)action
                                  size:(CGSize)size
                                 image:(nullable UIImage *)image
                             highImage:(nullable UIImage *)highImage;
```

- **UIButton+LCHelp**

```objective-c
typedef NS_ENUM(NSUInteger, LCButtonEdgeInsetsStyle) {
    LCButtonEdgeInsetsStyleTop, // Image Top，Label Bottom
    LCButtonEdgeInsetsStyleLeft, // Image Left，Label Right
    LCButtonEdgeInsetsStyleBottom, // Image Bottom，Label Top
    LCButtonEdgeInsetsStyleRight // Image Right，Label Left
};

@interface UIButton (LCHelp)
- (void)lc_setEdgeInsetsStyle:(LCButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;
@end
```

- **UIAlertController+LCHelp**

```objective-c
UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"alert" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
[alert lc_addActionWithTitle:@"sure" handler:^(UIAlertAction *action) {

}];
[self presentViewController:alert animated:YES completion:nil];
```

- **UIAlertView+LCHelp**

```objective-c
+ (instancetype)lc_alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)lc_alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
```

- **UIActionSheet+LCHelp**

```objective-c
+ (instancetype)lc_actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)lc_actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;
```

### Foundation

- **NSDate+LCHelp** 

```objective-c
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

+ (nullable NSDate *)lc_dateWithString:(NSString *)dateString format:(NSString *)format;
+ (nullable NSDate *)lc_dateWithString:(NSString *)dateString
                                format:(NSString *)format
                              timeZone:(nullable NSTimeZone *)timeZone
                                locale:(nullable NSLocale *)locale;
+ (nullable NSDate *)lc_dateWithISOFormatString:(NSString *)dateString;

- (nullable NSString *)lc_stringWithFormat:(NSString *)format; // "yyyy-MM-dd HH:mm:ss"
- (nullable NSString *)lc_stringWithFormat:(NSString *)format
                                  timeZone:(nullable NSTimeZone *)timeZone
                                    locale:(nullable NSLocale *)locale;
- (nullable NSString *)lc_stringWithISOFormat;

- (nullable NSDate *)lc_addYears:(NSInteger)years;
- (nullable NSDate *)lc_addMonths:(NSInteger)months;
- (nullable NSDate *)lc_addWeeks:(NSInteger)weeks;
- (nullable NSDate *)lc_addDays:(NSInteger)days;
- (nullable NSDate *)lc_addHours:(NSInteger)hours;
- (nullable NSDate *)lc_addMinutes:(NSInteger)minutes;
- (nullable NSDate *)lc_addSeconds:(NSInteger)seconds;
```

- **NSNumber+LCHelp**

```objective-c
+ (NSNumber *)lc_numberWithString:(NSString *)string;
```

- **NSObject+LCHelp**

```objective-c
@interface NSObject (LCHelp)

+ (BOOL)lc_swizzleClassMethod:(SEL)originalSel newMethod:(SEL)newSel;

+ (BOOL)lc_swizzleInstanceMethod:(SEL)originalSel newMethod:(SEL)newSel;

@end

@interface NSObject (LCSafe)

+ (id)lc_objectByRemovingKeysWithNullValues:(id)JSONObject; // remove null

@end
```

- **NSTimer+LCHelp**

```objective-c
+ (NSTimer *)lc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats action:(void (^)(NSTimer *timer))action;
- (void)lc_pauseTimer;
- (void)lc_resumeTimer;
- (void)lc_resumeTimerAfter:(NSTimeInterval)interval;
- (void)lc_stopTimer;

+ (void)lc_scheduledGCDTimerWithKey:(NSString *)aKey
                       timeInterval:(double)interval
                              queue:(dispatch_queue_t)queue
                            repeats:(BOOL)repeats
                             action:(dispatch_block_t)aAction;
+ (void)lc_cancelGCDTimerWithKey:(NSString *)aKey;
+ (void)lc_cancelAllGCDTimers;
```

- **NSString+LCHelp**


```objective-c
@property (readonly) char lc_charValue;
@property (readonly) unsigned char lc_unsignedCharValue;
@property (readonly) short lc_shortValue;
@property (readonly) unsigned short lc_unsignedShortValue;
@property (readonly) unsigned int lc_unsignedIntValue;
@property (readonly) long lc_longValue;
@property (readonly) unsigned long lc_unsignedLongValue;
@property (readonly) unsigned long long lc_unsignedLongLongValue;
@property (readonly) NSUInteger lc_unsignedIntegerValue;

+ (NSString *)lc_stringWithUUID;

+ (BOOL)lc_emptyString:(NSString *)string;
- (BOOL)lc_containsString:(NSString *)string;
- (BOOL)lc_hasPrefix:(NSString *)str;
- (BOOL)lc_hasSuffix:(NSString *)str;
- (BOOL)lc_equalsString:(NSString *)str;
- (BOOL)lc_containsEmoji;
+ (BOOL)lc_compareVersion:(NSString *)version sourceVersion:(NSString *)sourceVersion;

- (NSString *)lc_trim; // Remove whitespace before and after a string, excluding newlines.
- (NSString *)lc_removeWhiteSpace;
- (NSString *)lc_removeNewLine;
- (NSString *)lc_substringWithRange:(NSRange)range;

- (NSString *)lc_base64EncodedString;
- (NSString *)lc_base64DecodingString;
- (NSData *)lc_dataValue;
- (id)lc_jsonValue;
- (NSNumber *)lc_numberValue;

- (CGSize)lc_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
- (CGFloat)lc_widthForFont:(UIFont *)font;
- (CGFloat)lc_heightForFont:(UIFont *)font width:(CGFloat)width;
```

- **NSData+LCHelp**


```objective-c
- (id)lc_jsonValue;
- (NSString *)lc_base64EncodedString;
```

- **NSDictionary+LCHelp**


```objective-c
@interface NSDictionary (LCHelp)
+ (NSDictionary *)lc_dictionaryWithJsonString:(NSString *)jsonStr;
- (NSString*)lc_jsonString;
- (NSString *)lc_jsonPrettyString;
@end

@interface NSDictionary(LCSafe)
- (id)lc_objectForKey:(id)key;
- (int)lc_intValueForKey:(id)key;
- (NSInteger)lc_integerValueForKey:(id)key;
- (double)lc_doubleValueForKey:(id)key;
- (NSString*)lc_stringValueForKey:(id)key;

- (id)lc_objectForKey:(id)key asProtocol:(Protocol *)pro;
- (id)lc_objectForKey:(id)key asClass:(Class)cls;
@end

@interface NSMutableDictionary(LCSafe)
- (void)lc_setObject:(id)anObject forKey:(id)aKey;
@end
```

- **NSArray+LCHelp**


```objective-c
@interface NSArray (LCHelp)
+ (NSArray *)lc_arrayWithJsonString:(NSString *)jsonStr;
- (NSString *)lc_jsonString;
- (NSString *)lc_jsonPrettyString;
@end

@interface NSArray (LCSafe)
- (id)lc_objectAtIndex:(NSUInteger)index;
@end

@interface NSMutableArray (LCHelp)
- (void)lc_removeFirstObject;
- (void)lc_reverse;
@end
```

- **LCCrypto**


```objective-c
@interface NSString (LCMD5)
- (NSString *)lc_md5String;
@end

@interface NSData (LCMD5)
- (NSString *)lc_md5String;
@end

@interface NSData (LCHmac)
- (nullable NSString *)lc_hmacStringUsingAlg:(CCHmacAlgorithm)alg key:(NSString *)key;
- (nullable NSData *)lc_hmacDataUsingAlg:(CCHmacAlgorithm)alg key:(NSData *)key;
@end
```

## Installation

### CocoaPods

To integrate LCHelper into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'LCHelper'
```

### Manual

1. Download everything in the LCHelper folder;
2. Add (drag and drop) the source files in LCHelper to your project;
3. Import `LCHelper.h`.

## License

LCHelper is provided under the MIT license. See LICENSE file for details.
