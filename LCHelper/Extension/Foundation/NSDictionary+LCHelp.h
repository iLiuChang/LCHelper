//
//  NSDictionary+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/23.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (LCHelp)

- (NSString*)jsonString;

- (NSString *)jsonPrettyString;

+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonStr;

@end

@interface NSDictionary(LCSafe)

- (id)safeObjectForKey:(id)key;

- (int)intValueForKey:(id)key;

- (NSInteger)integerValueForKey:(id)key;

- (double)doubleValueForKey:(id)key;

- (NSString*)stringValueForKey:(id)key;

@end

@interface NSMutableDictionary(LCSafe)

- (void)safeSetObject:(id)anObject forKey:(id)aKey;

- (void)setIntValue:(int)value forKey:(id)aKey;

- (void)setDoubleValue:(double)value forKey:(id)aKey;

- (void)setStringValueForKey:(NSString*)string forKey:(id)aKey;

@end
