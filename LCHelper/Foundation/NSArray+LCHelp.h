//
//  NSArray+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/10.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (LCHelp)

+ (NSArray *)lc_arrayWithJsonString:(NSString *)jsonStr;
- (NSString *)lc_jsonString;
- (NSString *)lc_jsonPrettyString;

@end

@interface NSArray (LCSafe)

- (id)lc_objectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (LCHelp)

- (void)lc_removeFirstObject;
- (void)lc_reverse;

@end
