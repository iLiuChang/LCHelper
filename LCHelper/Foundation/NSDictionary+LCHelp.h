//
//  NSDictionary+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/4/23.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

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
