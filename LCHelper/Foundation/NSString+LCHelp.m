//
//  NSString+LCHelp.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "NSString+LCHelp.h"
#import "NSData+LCHelp.h"
#import "NSNumber+LCHelp.h"
#import "NSArray+LCHelp.h"

@implementation NSString (LCHelp)

- (char)lc_charValue {
    return self.lc_numberValue.charValue;
}

- (unsigned char)lc_unsignedCharValue {
    return self.lc_numberValue.unsignedCharValue;
}

- (short)lc_shortValue {
    return self.lc_numberValue.shortValue;
}

- (unsigned short)lc_unsignedShortValue {
    return self.lc_numberValue.unsignedShortValue;
}

- (unsigned int)lc_unsignedIntValue {
    return self.lc_numberValue.unsignedIntValue;
}

- (long)lc_longValue {
    return self.lc_numberValue.longValue;
}

- (unsigned long)lc_unsignedLongValue {
    return self.lc_numberValue.unsignedLongValue;
}

- (unsigned long long)lc_unsignedLongLongValue {
    return self.lc_numberValue.unsignedLongLongValue;
}

- (NSUInteger)lc_unsignedIntegerValue {
    return self.lc_numberValue.unsignedIntegerValue;
}

+ (NSString *)lc_stringWithUUID {
    CFUUIDRef uuid = CFUUIDCreate(NULL);
    CFStringRef string = CFUUIDCreateString(NULL, uuid);
    CFRelease(uuid);
    return (__bridge_transfer NSString *)string;
}

+ (BOOL)lc_emptyString:(NSString *)string {
    if ([string isKindOfClass:NSString.class]) {
        return string.length == 0;
    }
    return YES;
}

+ (BOOL)lc_compareVersion:(NSString *)version sourceVersion:(NSString *)sourceVersion {
    NSArray *versionArray = [version componentsSeparatedByString:@"."];
    NSArray *sourceVersionArray = [sourceVersion componentsSeparatedByString:@"."];
    NSUInteger count = MAX(versionArray.count, sourceVersionArray.count);
    for (NSUInteger i = 0; i<count; i++) {
        NSInteger newNum = [[versionArray lc_objectAtIndex:i] integerValue];
        NSInteger sourceNum = [[sourceVersionArray lc_objectAtIndex:i] integerValue];
        if (newNum > sourceNum) {
            return YES;
        } else if (newNum < sourceNum) {
            return NO;
        }
    }
    return NO;
}

- (BOOL)lc_containsString:(NSString *)string {
    return [self lc_containsString:string options:NSCaseInsensitiveSearch];
}

- (BOOL)lc_containsString:(NSString *)str options:(NSStringCompareOptions)compareOptions {
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length]) && ([self rangeOfString:str options:compareOptions].location != NSNotFound);
}

- (BOOL)lc_hasPrefix:(NSString *)str {
    return [self lc_hasPrefix:str options:NSCaseInsensitiveSearch];
}

- (BOOL)lc_hasPrefix:(NSString *)str options:(NSStringCompareOptions)compareOptions {
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:compareOptions].location == 0);
}

- (BOOL)lc_hasSuffix:(NSString *)str {
    return [self lc_hasSuffix:str Options:NSCaseInsensitiveSearch];
}

- (BOOL)lc_hasSuffix:(NSString *)str Options:(NSStringCompareOptions)compareOptions {
    return (str != nil) && ([str length] > 0) && ([self length] >= [str length])
    && ([self rangeOfString:str options:(compareOptions | NSBackwardsSearch)].location == ([self length] - [str length]));
}

- (BOOL)lc_equalsString:(NSString *)str {
    return (str != nil) && ([self length] == [str length]) && ([self rangeOfString:str options:NSCaseInsensitiveSearch].location == 0);
}

/// 去除字符串前后的空白,不包含换行符
- (NSString *)lc_trim {
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)lc_removeWhiteSpace {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)lc_removeNewLine {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}

- (NSString *)lc_substringWithRange:(NSRange)range {
    if ([NSString lc_emptyString:self]) {
        return nil;
    }
    if (range.location > self.length) {
        return nil;
    }
    if (range.location + range.length > self.length) {
        return nil;
    }
    return [self substringWithRange:range];
}

- (NSString *)lc_base64EncodedString {
    return [[self dataUsingEncoding:NSUTF8StringEncoding] lc_base64EncodedString];
}

- (NSString *)lc_base64DecodingString {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSString *domainBase64 =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return domainBase64;
}

- (NSData *)lc_dataValue {
    return [self dataUsingEncoding:NSUTF8StringEncoding];
}

- (id)lc_jsonValue {
    return [[self lc_dataValue] lc_jsonValue];
}

- (NSNumber *)lc_numberValue {
    return [NSNumber lc_numberWithString:self];
}

- (BOOL)lc_containsEmoji {
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff)
        {
            if (substring.length > 1)
            {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f)
                {
                    returnValue = YES;
                }
            }
        }
        else if (substring.length > 1)
        {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3)
            {
                returnValue = YES;
            }
        }
        else
        {
            if (0x2100 <= hs && hs <= 0x27ff)
            {
                returnValue = YES;
            }
            else if (0x2B05 <= hs && hs <= 0x2b07)
            {
                returnValue = YES;
            }
            else if (0x2934 <= hs && hs <= 0x2935)
            {
                returnValue = YES;
            }
            else if (0x3297 <= hs && hs <= 0x3299)
            {
                returnValue = YES;
            }
            else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
            {
                returnValue = YES;
            }
        }

        *stop = returnValue;
    }];
    return returnValue;
}

- (CGSize)lc_sizeForFont:(UIFont *)font size:(CGSize)size mode:(NSLineBreakMode)lineBreakMode {
    CGSize result;
    if (!font) font = [UIFont systemFontOfSize:12];
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSMutableDictionary *attr = [NSMutableDictionary new];
        attr[NSFontAttributeName] = font;
        if (lineBreakMode != NSLineBreakByWordWrapping) {
            NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            paragraphStyle.lineBreakMode = lineBreakMode;
            attr[NSParagraphStyleAttributeName] = paragraphStyle;
        }
        CGRect rect = [self boundingRectWithSize:size
                                         options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                      attributes:attr context:nil];
        result = rect.size;
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        result = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
#pragma clang diagnostic pop
    }
    return result;
}

- (CGFloat)lc_widthForFont:(UIFont *)font {
    CGSize size = [self lc_sizeForFont:font size:CGSizeMake(HUGE, HUGE) mode:NSLineBreakByWordWrapping];
    return size.width;
}

- (CGFloat)lc_heightForFont:(UIFont *)font width:(CGFloat)width {
    CGSize size = [self lc_sizeForFont:font size:CGSizeMake(width, HUGE) mode:NSLineBreakByWordWrapping];
    return size.height;
}

@end


