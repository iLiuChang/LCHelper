//
//  NSDictionary+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/23.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LCHelp)

- (NSString*)lc_jsonString;

- (NSString *)lc_jsonPrettyString;

+ (NSDictionary *)lc_dictionaryWithJsonString:(NSString *)jsonStr;

@end

@interface NSDictionary(LCSafe)

/// 废弃 请使用 "lc_objectForKey:"
- (id)safeObjectForKey:(id)key;

- (id)lc_objectForKey:(id)key;

- (int)lc_intValueForKey:(id)key;

- (NSInteger)lc_integerValueForKey:(id)key;

- (double)lc_doubleValueForKey:(id)key;

- (NSString*)lc_stringValueForKey:(id)key;

@end

@interface NSMutableDictionary(LCSafe)

- (void)lc_setObject:(id)anObject forKey:(id)aKey;

@end
