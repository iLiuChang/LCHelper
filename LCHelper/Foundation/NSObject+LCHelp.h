//
//  NSObject+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LCHelp)

+ (BOOL)lc_swizzleClassMethod:(SEL)originalSel newMethod:(SEL)newSel;

+ (BOOL)lc_swizzleInstanceMethod:(SEL)originalSel newMethod:(SEL)newSel;

@end

@interface NSObject (LCSafe)

+ (id)lc_objectByRemovingKeysWithNullValues:(id)JSONObject; // remove null

@end
