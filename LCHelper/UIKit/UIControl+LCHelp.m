//
//  UIControl+LCHelp.m
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 16/7/1.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "UIControl+LCHelp.h"
#import <objc/runtime.h>

static const NSString *_lc_block_key = @"_lc_block_key";

@interface LCUIControlBlockTarget : NSObject

@property (nonatomic, copy) void (^block)(id sender);
@property (nonatomic, assign) UIControlEvents events;

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events;
- (void)invoke:(id)sender;

@end

@implementation LCUIControlBlockTarget

- (id)initWithBlock:(void (^)(id sender))block events:(UIControlEvents)events {
    self = [super init];
    if (self) {
        _block = [block copy];
        _events = events;

    }
    return self;
}

- (void)invoke:(id)sender {
    if (_block) _block(sender);
}

@end



@implementation UIControl (LCHelp)


- (void)lc_removeAllTargets {
    [[self allTargets] enumerateObjectsUsingBlock: ^(id object, BOOL *stop) {
        [self removeTarget:object action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self allUIControlBlockTargets] removeAllObjects];
}

- (void)lc_addEventTouchUpInsideBlock:(void (^)(id sender))block {
    LCUIControlBlockTarget *target = [[LCUIControlBlockTarget alloc]
                                      initWithBlock:block events:UIControlEventTouchUpInside];
    [self addTarget:target action:@selector(invoke:) forControlEvents:UIControlEventTouchUpInside];
    NSMutableArray *targets = [self allUIControlBlockTargets];
    [targets addObject:target];
}
- (void)lc_addEvents:(UIControlEvents)controlEvents
                           invoke:(void (^)(id sender))block {
    if (!controlEvents)  return;
    
    LCUIControlBlockTarget *target = [[LCUIControlBlockTarget alloc]
                                       initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self allUIControlBlockTargets];
    [targets addObject:target];
}

- (void)lc_setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    if (!target || !action || !controlEvents) return;
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *actions = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in actions) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction)
              forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

- (void)lc_setEvents:(UIControlEvents)controlEvents
                           invoke:(void (^)(id sender))block {
    [self lc_removeAllBlocksForControlEvents:UIControlEventAllEvents];
    [self lc_addEvents:controlEvents invoke:block];
}

- (void)lc_removeAllBlocksForControlEvents:(UIControlEvents)controlEvents {
    if (!controlEvents) return;
    
    NSMutableArray *targets = [self allUIControlBlockTargets];
    NSMutableArray *removes = [NSMutableArray array];
    for (LCUIControlBlockTarget *target in targets) {
        if (target.events & controlEvents) {
            UIControlEvents newEvent = target.events & (~controlEvents);
            if (newEvent) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = newEvent;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            } else {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}

- (NSMutableArray *)allUIControlBlockTargets {
    NSMutableArray *targets = objc_getAssociatedObject(self, &_lc_block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &_lc_block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}




@end
