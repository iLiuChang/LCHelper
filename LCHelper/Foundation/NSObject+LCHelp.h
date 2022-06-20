//
//  NSObject+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (LCHelp)

+ (BOOL)lc_swizzleClassMethod:(SEL)originalSel newMethod:(SEL)newSel;

+ (BOOL)lc_swizzleInstanceMethod:(SEL)originalSel newMethod:(SEL)newSel;

@end

@interface NSObject (LCSafe)

+ (nullable id)lc_objectByRemovingKeysWithNullValues:(nullable id)JSONObject; // remove null

@end

NS_ASSUME_NONNULL_END
