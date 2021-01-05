//
//  LCCrypto.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2021/1/4.
//  Copyright © 2021 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <CommonCrypto/CommonCrypto.h>

NS_ASSUME_NONNULL_BEGIN

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
NS_ASSUME_NONNULL_END
