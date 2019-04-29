//
//  UIView+LCKeyboardObserver.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UITextField+LCKeyboardObserver.h"
#import <objc/runtime.h>
#import "LCKeyboardObserver.h"

@implementation UITextField (LCKeyboardObserver)

- (void)addKeyboardObserver {
    [self addKeyboardObserverWithTransformView:nil];
}

- (void)addKeyboardObserverWithTransformView:(UIView *)view {
    LCKeyboardObserver *observer = [[LCKeyboardObserver alloc] initWithObserveView:self transformView:view];
    [self lc_setKeyboardObserver:observer];
}

- (void)removeKeyboardObserver {
    [[self lc_keyboardObserver] removeObserver];
}

static const char LCKeyboardObserverKey = '\0';
- (void)lc_setKeyboardObserver:(LCKeyboardObserver *)observer {
    objc_setAssociatedObject(self, &LCKeyboardObserverKey,
                             observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (LCKeyboardObserver *)lc_keyboardObserver {
    return objc_getAssociatedObject(self, &LCKeyboardObserverKey);
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self removeKeyboardObserver];
        [self lc_setKeyboardObserver:nil];
    }
}
@end
