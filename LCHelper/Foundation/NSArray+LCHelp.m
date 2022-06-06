//
//  NSArray+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/10.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "NSArray+LCHelp.h"
#import "NSString+LCHelp.h"

@implementation NSArray (LCHelp)

- (NSString *)lc_jsonString {
    return [self lc_jsonStringWithOptions:0];
}

- (NSString *)lc_jsonPrettyString {
    return [self lc_jsonStringWithOptions:NSJSONWritingPrettyPrinted];
}

- (NSString *)lc_jsonStringWithOptions:(NSJSONWritingOptions)opt {
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self options:opt error:&error];
        NSString *json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        if (!error) return json;
    }
    return nil;
}

+ (NSArray *)lc_arrayWithJsonString:(NSString *)jsonStr {
    id value = [jsonStr lc_jsonValue];
    if (value && [value isKindOfClass:[NSArray class]]) {
        return value;
    }
    return nil;
}

@end

@implementation NSArray (LCSafe)

- (id)lc_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) return nil;
    id obj = self[index];
    if ([obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return self[index];
}

@end

@implementation NSMutableArray (LCHelp)

- (void)lc_removeFirstObject {
    if (self.count) {
        [self removeObjectAtIndex:0];
    }
}

- (void)lc_reverse {
    NSUInteger count = self.count;
    int mid = floor(count / 2.0);
    for (NSUInteger i = 0; i < mid; i++) {
        [self exchangeObjectAtIndex:i withObjectAtIndex:(count - (i + 1))];
    }
}

@end
