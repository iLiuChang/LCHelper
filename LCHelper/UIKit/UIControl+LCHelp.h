//
//  UIControl+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/7/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIControl (LCHelp)

- (void)lc_addEventTouchUpInsideBlock:(void (^)(id sender))block;

- (void)lc_addEvents:(UIControlEvents)controlEvents invoke:(void (^)(id sender))block;

- (void)lc_setEvents:(UIControlEvents)controlEvents invoke:(void (^)(id sender))block;

- (void)lc_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

- (void)lc_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents;

- (void)lc_removeAllTargets;
@end

NS_ASSUME_NONNULL_END
