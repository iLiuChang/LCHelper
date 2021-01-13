//
//  NSDictionary+LCHelp.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/23.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "NSDictionary+LCHelp.h"
#import "NSString+LCHelp.h"

#define isValidKey(key) ((key) != nil && ![key isKindOfClass:[NSNull class]])
#define isValidValue(value) (((value) != nil) && ![value isKindOfClass:[NSNull class]])

@implementation NSDictionary (LCHelp)

- (NSString*)lc_jsonString {
    return [self lc_jsonStringWithOptions:0];
}

- (NSString *)lc_jsonPrettyString {
    return [self lc_jsonStringWithOptions:NSJSONWritingPrettyPrinted];
}

- (NSString *)lc_jsonStringWithOptions:(NSJSONWritingOptions)opt {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:opt error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

+ (NSDictionary *)lc_dictionaryWithJsonString:(NSString *)jsonStr {
    id value = [jsonStr lc_jsonValue];
    if (value && [value isKindOfClass:[NSDictionary class]]) {
        return value;
    }
    return nil;
}

@end

@implementation NSDictionary (LCSafe)

- (id)safeObjectForKey:(id)key {
    return [self lc_objectForKey:key];
}

- (id)lc_objectForKey:(id)key{
    if (!isValidKey(key)) {
        return nil;
    }
    id obj = [self objectForKey:key];
    if(!isValidValue(obj))
        return nil;
    return obj;
}

- (int)lc_intValueForKey:(id)key{
    id obj = [self lc_objectForKey:key];
    return [obj intValue];
}

- (NSInteger)lc_integerValueForKey:(id)key{
    id obj = [self lc_objectForKey:key];
    return [obj integerValue];
}

- (double)lc_doubleValueForKey:(id)key{
    id obj = [self lc_objectForKey:key];
    return [obj doubleValue];
}

- (NSString*)lc_stringValueForKey:(id)key{
    id obj = [self lc_objectForKey:key];
    if ([obj isKindOfClass:NSString.class]) {
        return obj;
    }
    if ([obj respondsToSelector:@selector(stringValue)]) {
        return [obj stringValue];
    }
    return nil;
}

@end


@implementation NSMutableDictionary(LCSafe)

- (void)lc_setObject:(id)anObject forKey:(id)aKey{
    if (!isValidKey(aKey)) {
        return;
    }
    if ([aKey isKindOfClass:[NSString class]]) {
        [self setValue:anObject forKey:aKey];
    } else {
        if (anObject != nil) {
            [self setObject:anObject forKey:aKey];
        } else {
            [self removeObjectForKey:aKey];
        }
    }
}

@end
