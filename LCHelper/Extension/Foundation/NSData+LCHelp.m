//
//  NSData+LCHelp.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/3/28.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "NSData+LCHelp.h"
#include <CommonCrypto/CommonCrypto.h>

@implementation NSData (LCHelp)

- (id)jsonValue {
    NSError *error = nil;
    id value = [NSJSONSerialization JSONObjectWithData:self options:kNilOptions error:&error];
    if (error) {
        NSLog(@"jsonValue error:%@", error);
    }
    return value;
}

static const char base64EncodingTable[64]
= "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

- (NSString *)base64EncodedString {
    NSUInteger length = self.length;
    if (length == 0)
        return @"";
    
    NSUInteger out_length = ((length + 2) / 3) * 4;
    uint8_t *output = malloc(((out_length + 2) / 3) * 4);
    if (output == NULL)
        return nil;
    
    const char *input = self.bytes;
    NSInteger i, value;
    for (i = 0; i < length; i += 3) {
        value = 0;
        for (NSInteger j = i; j < i + 3; j++) {
            value <<= 8;
            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }
        NSInteger index = (i / 3) * 4;
        output[index + 0] = base64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = base64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = ((i + 1) < length)
        ? base64EncodingTable[(value >> 6) & 0x3F]
        : '=';
        output[index + 3] = ((i + 2) < length)
        ? base64EncodingTable[(value >> 0) & 0x3F]
        : '=';
    }
    
    NSString *base64 = [[NSString alloc] initWithBytes:output
                                                length:out_length
                                              encoding:NSASCIIStringEncoding];
    free(output);
    return base64;
}
@end


@implementation NSData (LCSHA)
- (NSString *)hmacSHA1StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSData *)hmacSHA1DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA1 withKey:key];
}

- (NSString *)hmacSHA224StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSData *)hmacSHA224DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA224 withKey:key];
}

- (NSString *)hmacSHA256StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSData *)hmacSHA256DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA256 withKey:key];
}

- (NSString *)hmacSHA384StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSData *)hmacSHA384DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA384 withKey:key];
}

- (NSString *)hmacSHA512StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSData *)hmacSHA512DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgSHA512 withKey:key];
}

- (NSString *)hmacStringUsingAlg:(CCHmacAlgorithm)alg withKey:(NSString *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    const char *cKey = [key cStringUsingEncoding:NSUTF8StringEncoding];
    CCHmac(alg, cKey, strlen(cKey), self.bytes, self.length, result);
    NSMutableString *hash = [NSMutableString stringWithCapacity:size * 2];
    for (int i = 0; i < size; i++) {
        [hash appendFormat:@"%02x", result[i]];
    }
    return hash;
}

- (NSData *)hmacDataUsingAlg:(CCHmacAlgorithm)alg withKey:(NSData *)key {
    size_t size;
    switch (alg) {
        case kCCHmacAlgMD5: size = CC_MD5_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA1: size = CC_SHA1_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA224: size = CC_SHA224_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA256: size = CC_SHA256_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA384: size = CC_SHA384_DIGEST_LENGTH; break;
        case kCCHmacAlgSHA512: size = CC_SHA512_DIGEST_LENGTH; break;
        default: return nil;
    }
    unsigned char result[size];
    CCHmac(alg, [key bytes], key.length, self.bytes, self.length, result);
    return [NSData dataWithBytes:result length:size];
}

@end


@implementation NSData (LCMD5)
- (NSString *)md5String {
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(self.bytes, (CC_LONG)self.length, result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)hmacMD5StringWithKey:(NSString *)key {
    return [self hmacStringUsingAlg:kCCHmacAlgMD5 withKey:key];
}

- (NSData *)hmacMD5DataWithKey:(NSData *)key {
    return [self hmacDataUsingAlg:kCCHmacAlgMD5 withKey:key];
}
@end
