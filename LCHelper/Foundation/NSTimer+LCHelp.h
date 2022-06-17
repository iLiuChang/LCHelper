//
//  NSTimer+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/7/25.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (LCHelp)

+ (void)lc_scheduledGCDTimerWithKey:(NSString *)aKey
                       timeInterval:(double)interval
                              queue:(dispatch_queue_t)queue
                            repeats:(BOOL)repeats
                             action:(dispatch_block_t)aAction;
+ (void)lc_cancelGCDTimerWithKey:(NSString *)aKey;
+ (void)lc_cancelAllGCDTimers;

@end
