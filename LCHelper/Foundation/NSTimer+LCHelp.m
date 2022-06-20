//
//  NSTimer+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/7/25.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "NSTimer+LCHelp.h"
#import <objc/runtime.h>

@implementation NSTimer (LCTimer)

+ (void)_timerActionBlock:(NSTimer *)timer {
    if ([timer userInfo]) {
        void (^block)(NSTimer *timer) = (void (^)(NSTimer *timer))[timer userInfo];
        block(timer);
    }
}

+ (NSTimer *)lc_scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats action:(void (^)(NSTimer *timer))action {
    return [NSTimer scheduledTimerWithTimeInterval:seconds target:self selector:@selector(_timerActionBlock:) userInfo:[action copy] repeats:repeats];
}

- (void)lc_pauseTimer {
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate distantFuture]];
}

- (void)lc_resumeTimer {
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate date]];
}

- (void)lc_resumeTimerAfter:(NSTimeInterval)interval {
    if (!self.isValid) {
        return;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

- (void)lc_stopTimer {
    if (!self.isValid) {
        return;
    }
    [self invalidate];
}

@end


static const NSString *_lc_timer_cache_key = @"_lc_timer_cache_key";

@implementation NSTimer (LCGCDTimer)

+ (void)lc_scheduledGCDTimerWithKey:(NSString *)aKey
                    timeInterval:(double)interval
                           queue:(dispatch_queue_t)queue
                         repeats:(BOOL)repeats
                          action:(dispatch_block_t)aAction {
    
    NSMutableDictionary *caches = objc_getAssociatedObject(self, &_lc_timer_cache_key);
    if (!caches) {
        caches = [[NSMutableDictionary alloc] init];
        objc_setAssociatedObject(self, &_lc_timer_cache_key, caches, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (!queue) queue = dispatch_get_main_queue();
    
    dispatch_source_t timer = [caches objectForKey:aKey];
    if (!timer) {
        timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        [caches setObject:timer forKey:aKey];
        dispatch_resume(timer);
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.01 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            if (!repeats) {
                [caches removeObjectForKey:aKey];
                dispatch_source_cancel(timer);
            }
            if (aAction) {
                aAction();
            }
        });
    }
    
}

+ (void)lc_cancelGCDTimerWithKey:(NSString *)aKey {
     NSMutableDictionary *caches = objc_getAssociatedObject(self, &_lc_timer_cache_key);
    if (caches) {
        dispatch_source_t timer = [caches objectForKey:aKey];
        if (timer) {
            dispatch_source_cancel(timer);
        }
        [caches removeObjectForKey:aKey];
    }
}

+ (void)lc_cancelAllGCDTimers {
    NSMutableDictionary *caches = objc_getAssociatedObject(self, &_lc_timer_cache_key);
    if (caches) {
        [caches enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            dispatch_source_t timer = (dispatch_source_t)obj;
            dispatch_source_cancel(timer);
        }];
        [caches removeAllObjects];
    }
}


@end
