//
//  NSObject+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/6/30.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (LCHelp)
/**
 *  交换类方法
 */
+ (BOOL)swizzleClassMethod:(SEL)originalSel newMethod:(SEL)newSel;

/**
 *  交换对象方法
 */
+ (BOOL)swizzleInstanceMethod:(SEL)originalSel newMethod:(SEL)newSel;

@end
