//
//  UIControl+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/7/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (LCHelp)

/**
 *  添加TouchUpInside事件
 *
 */
- (void)lc_addEventTouchUpInsideBlock:(void (^)(id sender))block;

/**
 *  添加事件
 *
 */
- (void)lc_addEvents:(UIControlEvents)controlEvents
            invoke:(void (^)(id sender))block;

/**
 *  添加事件（会删除之前添加的所有事件）
 *
 */
- (void)lc_setEvents:(UIControlEvents)controlEvents
                           invoke:(void (^)(id sender))block;

/**
 *  添加事件
 *
 */
- (void)lc_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

/**
 *  删除指定的事件
 *
 */
- (void)lc_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

/**
 *  移除所有事件
 */
- (void)lc_removeAllTargets;
@end
