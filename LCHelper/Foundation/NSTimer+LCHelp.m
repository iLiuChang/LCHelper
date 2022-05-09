//
//  NSTimer+Extension.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/7/25.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "NSTimer+LCHelp.h"
#import <objc/runtime.h>

static const NSString *_lc_timer_cache_key = @"_lc_timer_cache_key";

@implementation NSTimer (LCHelp)
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
        // 精度为0.1秒
        dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, interval * NSEC_PER_SEC), interval * NSEC_PER_SEC, 0.1 * NSEC_PER_SEC);
        dispatch_source_set_event_handler(timer, ^{
            aAction();
            if (!repeats) {
                dispatch_source_cancel(timer);
            }
        });
    }
    
}

+ (void)lc_cancelWithKey:(NSString *)aKey {
     NSMutableDictionary *caches = objc_getAssociatedObject(self, &_lc_timer_cache_key);
    if (caches) {
        dispatch_source_t timer = [caches objectForKey:aKey];
        if (timer) {
            dispatch_source_cancel(timer);
        }
        [caches removeObjectForKey:aKey];
    }
}

+ (void)lc_cancelAll {
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
