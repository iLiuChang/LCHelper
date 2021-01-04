//
//  NSData+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (LCHelp)

- (id)jsonValue;

- (NSString *)base64EncodedString;

@end


@interface NSData (LCMD5)
- (NSString *)md5String;

- (NSString *)hmacMD5StringWithKey:(NSString *)key;

- (NSData *)hmacMD5DataWithKey:(NSData *)key;
@end


@interface NSData (LCSHA)
- (NSString *)hmacSHA1StringWithKey:(NSString *)key;

- (NSData *)hmacSHA1DataWithKey:(NSData *)key;

- (NSString *)hmacSHA224StringWithKey:(NSString *)key;

- (NSData *)hmacSHA224DataWithKey:(NSData *)key;

- (NSString *)hmacSHA256StringWithKey:(NSString *)key;

- (NSData *)hmacSHA256DataWithKey:(NSData *)key;

- (NSString *)hmacSHA384StringWithKey:(NSString *)key;

- (NSData *)hmacSHA384DataWithKey:(NSData *)key;

- (NSString *)hmacSHA512StringWithKey:(NSString *)key;

- (NSData *)hmacSHA512DataWithKey:(NSData *)key;
@end
