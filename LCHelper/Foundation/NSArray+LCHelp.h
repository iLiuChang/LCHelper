//
//  NSArray+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/10.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSArray (LCHelp)

+ (nullable NSArray *)lc_arrayWithJsonString:(NSString *)jsonStr;
- (nullable NSString *)lc_jsonString;
- (nullable NSString *)lc_jsonPrettyString;

@end

@interface NSArray (LCSafe)

- (nullable id)lc_objectAtIndex:(NSUInteger)index;
- (nullable id)lc_objectAtIndex:(NSUInteger)index asProtocol:(Protocol *)pro;
- (nullable id)lc_objectAtIndex:(NSUInteger)index asClass:(Class)cls;

@end

@interface NSMutableArray (LCHelp)

- (void)lc_removeFirstObject;
- (void)lc_reverse;

@end

NS_ASSUME_NONNULL_END
