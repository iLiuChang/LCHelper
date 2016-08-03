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
+ (void)swizzleClassMethod:(Class)class
            originSelector:(SEL)originSelector
             otherSelector:(SEL)otherSelector;

/**
 *  交换对象方法
 */
+ (void)swizzleInstanceMethod:(Class)class
               originSelector:(SEL)originSelector
                otherSelector:(SEL)otherSelector;

/**
 *  移除空对象
 *
 *  @item 字典或者数组
 */
+ (id)removeNullObjectWithAnyObject:(id)item;

/**
 *  移除空对象
 */
- (id)removeNullObjects;

/**
 *  null转为nil
 */
- (id)nullTonil;
@end
