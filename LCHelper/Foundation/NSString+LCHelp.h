//
//  NSString+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LCHelp)

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

- (nullable NSString *)lc_trim; // Remove whitespace before and after a string, excluding newlines.
- (nullable NSString *)lc_removeWhiteSpace;
- (nullable NSString *)lc_removeNewLine;
- (nullable NSString *)lc_substringWithRange:(NSRange)range;

- (nullable NSString *)lc_base64EncodedString;
- (nullable NSString *)lc_base64DecodingString;
- (nullable NSData *)lc_dataValue;
- (nullable id)lc_jsonValue;
- (nullable NSNumber *)lc_numberValue;

- (CGSize)lc_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;
- (CGFloat)lc_widthForFont:(UIFont *)font;
- (CGFloat)lc_heightForFont:(UIFont *)font width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END

