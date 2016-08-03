//
//  NSObject+Extension.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "NSObject+LCHelp.h"
#import <objc/runtime.h>
@implementation NSObject (LCHelp)
+ (void)swizzleClassMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector {
    Method otherMehtod = class_getClassMethod(class, otherSelector);
    Method originMehtod = class_getClassMethod(class, originSelector);
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (void)swizzleInstanceMethod:(Class)class originSelector:(SEL)originSelector otherSelector:(SEL)otherSelector {
    Method otherMehtod = class_getInstanceMethod(class, otherSelector);
    Method originMehtod = class_getInstanceMethod(class, originSelector);
    method_exchangeImplementations(otherMehtod, originMehtod);
}

+ (id)removeNullObjectWithAnyObject:(id)item {
    if([item isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:item];
        for (NSString *key in [dic allKeys]) {
            id value = [dic objectForKey:key];
            id obj = [self removeNullObjectWithAnyObject:value];
            if (obj) {
                [dic setObject:obj forKey:key];
            }
            else {
                [dic removeObjectForKey:key];
            }
        }
        return dic;
    }else if([item isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr= [NSMutableArray arrayWithArray:item];
        for (NSInteger i = [arr count]-1; i >= 0; i--) {
            id value = [arr objectAtIndex:i];
            id obj = [self removeNullObjectWithAnyObject:value];
            if (obj) {
                [arr replaceObjectAtIndex:i withObject:obj];
            }
            else {
                [arr removeObjectAtIndex:i];
            }
        }
        return arr;
    }
    return [item nullTonil];
}

- (id)nullTonil {
    if ([self isKindOfClass:[NSNull class]]) {
        return nil;
    }
    return self;
}

- (id)removeNullObjects {
    return [NSObject removeNullObjectWithAnyObject:self];
}
@end
