//
//  NSTimer+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/7/25.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (LCTimer)

+ (NSTimer *)lc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats action:(void (^)(NSTimer *timer))action;
- (void)lc_pauseTimer;
- (void)lc_resumeTimer;
- (void)lc_resumeTimerAfter:(NSTimeInterval)interval;
- (void)lc_stopTimer;

@end


@interface NSTimer (LCGCDTimer)

+ (void)lc_scheduledGCDTimerWithKey:(NSString *)aKey
                       timeInterval:(double)interval
                              queue:(nullable dispatch_queue_t)queue
                            repeats:(BOOL)repeats
                             action:(dispatch_block_t)aAction;
+ (void)lc_cancelGCDTimerWithKey:(NSString *)aKey;
+ (void)lc_cancelAllGCDTimers;

@end

NS_ASSUME_NONNULL_END
