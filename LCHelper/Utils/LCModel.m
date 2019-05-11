//
//  LCModel.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "LCModel.h"
#import <objc/runtime.h>

@implementation LCModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dic {
    return [[self alloc] initWithDictionary:dic];
}

- (instancetype)initWithDictionary:(NSDictionary *)dic {
    
    if (![dic isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    if (self = [super init]) {
        [self setValuesWithDictionary:dic];
    }
    return self;
}

- (void)setValuesWithDictionary:(NSDictionary *)dic {
    [self setValuesForKeysWithDictionary:dic];
}
- (void)setValue:(id)value forKey:(NSString *)key {
    if ([value isKindOfClass:[NSNull class]]) {
        value = nil;
    }
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSDictionary *dic = [self exchangeValuesForKeys];
    if (dic) {
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull aKey, id  _Nonnull aObj, BOOL * _Nonnull stop) {
            if (key == aKey) {
                [self setValue:value forKey:aObj];
            }
        }];
    }
}

- (NSDictionary *)exchangeValuesForKeys {
    return nil;
}

- (NSString *)modelToJSONString {
    NSDictionary *dic = [self modelToDictionary];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

- (NSDictionary *)modelToDictionary {
    NSMutableDictionary *aDic = [[NSMutableDictionary alloc] init];
    unsigned int count = 0;
    objc_property_t* properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        objc_property_t prop = properties[i];
        const char *name = property_getName(prop);
        NSString *key = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:key];
        if (value) {
            if ([value isKindOfClass:[LCModel class]]) {
                NSDictionary *dic = [(LCModel *)value modelToDictionaryRemoveNull];
                [aDic setValue:dic forKey:key];
            } else if([value isKindOfClass:[NSArray class]]) {
                NSArray *arr = (NSArray *)value;
                NSMutableArray *mArr = [NSMutableArray array];
                for (NSObject *item in arr) {
                    if ([item isKindOfClass:[LCModel class]]) {
                        NSDictionary *dic = [(LCModel *)item modelToDictionaryRemoveNull];
                        if (dic) {
                            [mArr addObject:dic];
                        }
                    }
                    else {
                        [mArr addObject:item];
                    }
                }
                [aDic setValue:mArr forKey:key];
            }else {
                [aDic setValue:value forKey:key];
            }
        }
    }
    free(properties);
    return aDic;
}

- (NSDictionary *)modelToDictionaryRemoveNull {
    return [self modelToDictionary];
}

@end
