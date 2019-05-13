//
//  NSString+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (LCHelp)

@property (readonly) char charValue;
@property (readonly) unsigned char unsignedCharValue;
@property (readonly) short shortValue;
@property (readonly) unsigned short unsignedShortValue;
@property (readonly) unsigned int unsignedIntValue;
@property (readonly) long longValue;
@property (readonly) unsigned long unsignedLongValue;
@property (readonly) unsigned long long unsignedLongLongValue;
@property (readonly) NSUInteger unsignedIntegerValue;

- (BOOL)isEmpty;

- (BOOL)containsString:(NSString *)string;

- (NSString *)base64EncodedString;

- (NSString *)base64DecodingString;

- (NSData *)dataValue;

- (id)jsonValue;

- (NSNumber *)numberValue;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

+ (NSString *)stringWithUUID;

@end


@interface NSString (LCMD5)
- (NSString *)md5String;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;
@end


@interface NSString (LCSHA)
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

- (NSString *)hmacSHA512StringWithKey:(NSString *)key;
@end
