//
//  NSString+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (LCHelp)

- (BOOL)isEmpty;

- (BOOL)containsString:(NSString *)string;

- (NSString *)md5String;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;

- (NSString *)base64EncodedString;

- (NSString *)base64DecodingString;

- (CGSize)sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode;

- (CGFloat)widthForFont:(UIFont *)font;

- (CGFloat)heightForFont:(UIFont *)font width:(CGFloat)width;

+ (NSString *)stringWithUUID;

@end
