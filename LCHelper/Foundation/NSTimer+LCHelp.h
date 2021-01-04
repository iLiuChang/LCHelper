//
//  NSTimer+Extension.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/7/25.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (LCHelp)

/**
 *  开启定时器
 *
 *  @param aKey     唯一的key
 *  @param interval 间隔
 *  @param queue    添加队列，默认为主队列
 *  @param repeats  是否重复
 *  @param aAction  回调闭包
 */
+ (void)scheduledGCDTimerWithKey:(NSString *)aKey
                    TimeInterval:(double)interval
                           queue:(dispatch_queue_t)queue
                         repeats:(BOOL)repeats
                          action:(dispatch_block_t)aAction;

/**
 *  取消定时器
 *
 *  @param aKey 唯一的key
 */
+ (void)cancelWithKey:(NSString *)aKey;

/**
 *  取消所有通过CGD创建的定时器
 */
+ (void)cancelAll ;
@end
