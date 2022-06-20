//
//  NSDictionary+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/4/23.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (LCHelp)

+ (nullable NSDictionary *)lc_dictionaryWithJsonString:(NSString *)jsonStr;
- (nullable NSString*)lc_jsonString;
- (nullable NSString *)lc_jsonPrettyString;

@end

@interface NSDictionary(LCSafe)

- (id)lc_objectForKey:(id)key;
- (int)lc_intValueForKey:(id)key;
- (NSInteger)lc_integerValueForKey:(id)key;
- (double)lc_doubleValueForKey:(id)key;
- (nullable NSString *)lc_stringValueForKey:(id)key;

- (nullable id)lc_objectForKey:(id)key asProtocol:(Protocol *)pro;
- (nullable id)lc_objectForKey:(id)key asClass:(Class)cls;

@end

@interface NSMutableDictionary(LCSafe)

- (void)lc_setObject:(nullable id)anObject forKey:(id)aKey;

@end

NS_ASSUME_NONNULL_END
