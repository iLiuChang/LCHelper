//
//  NSString+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

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

/// 去除字符串前后的空白,不包含换行符
- (NSString *)lc_trim;

- (NSString *)lc_removeWhiteSpace;

- (NSString *)lc_removeNewLine;

- (NSString *)lc_substringWithRange:(NSRange)range;

- (NSString *)lc_base64EncodedString;

- (NSString *)lc_base64DecodingString;

- (NSData *)lc_dataValue;

- (id)lc_jsonValue;

- (NSNumber *)lc_numberValue;

- (BOOL)lc_containsEmoji;

- (CGSize)lc_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)lc_widthForFont:(UIFont *)font;

- (CGFloat)lc_heightForFont:(UIFont *)font width:(CGFloat)width;

@end


