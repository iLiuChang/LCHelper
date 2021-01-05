//
//  UIView+LCKeyboardObserver.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIView+LCKeyboardObserver.h"
#import <objc/runtime.h>

@interface LCKeyboardObserver : NSObject

@property (nonatomic, assign) CGFloat keyboardSpacing;

- (instancetype)initWithObserveView:(UIView *)observeView transformView:(UIView *)transformView;

- (void)removeObserver;

@end

@interface LCKeyboardObserver()

@property(nonatomic, weak) UIView *observeView;

@property(nonatomic, weak) UIView *transformView;

@property(nonatomic, assign) BOOL isRemoveObserver;

@end

@implementation LCKeyboardObserver

- (instancetype)initWithObserveView:(UIView *)observeView transformView:(UIView *)transformView
{
    self = [super init];
    if (self) {
        if (!observeView) {
            NSLog(@"observeView can not be nil");
            return self;
        }
        self.keyboardSpacing = 20;
        self.observeView = observeView;
        self.transformView = transformView;
        if (!self.transformView) {
            UIView *superView = observeView.superview;
            if (!superView) {
                NSLog(@"observeView superview is nil");
                return self;
            }
            self.transformView = superView;
        }

        [self addKeyboardObserver];
    }
    return self;
}

- (void)addKeyboardObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)note{
    if (!self.observeView.isFirstResponder) {
        return;
    }
    CGFloat telMaxY = CGRectGetMaxY(self.observeView.frame);
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = self.transformView.frame.size.height - keyboardH;
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration < 0.0){
        duration = 0.25;
    };
    [UIView animateWithDuration:duration animations:^{
        if (telMaxY > keyboardY) {
            self.transformView.transform = CGAffineTransformMakeTranslation(0,  keyboardY - telMaxY - self.keyboardSpacing);
        }else {
            self.transformView.transform = CGAffineTransformIdentity;
        }
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)note{
    double duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.transformView.transform = CGAffineTransformIdentity;
    }];
}

- (void)dealloc {
    [self removeObserver];
}

-(void)removeObserver {
    if (self.isRemoveObserver) {
        return;
    }
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    self.isRemoveObserver = YES;
}
@end

@implementation UIView (LCKeyboardObserver)

- (void)lc_addKeyboardObserver {
    [self lc_addKeyboardObserverWithTransformView:nil];
}

- (void)lc_addKeyboardObserverWithTransformView:(UIView *)view {
    [self lc_addKeyboardObserverWithTransformView:view keyboardSpacing:20];
}

- (void)lc_addKeyboardObserverWithTransformView:(UIView *)view keyboardSpacing:(CGFloat)keyboardSpacing {
    LCKeyboardObserver *observer = [[LCKeyboardObserver alloc] initWithObserveView:self transformView:view];
    observer.keyboardSpacing = keyboardSpacing;
    [self lc_setKeyboardObserver:observer];
}

- (void)lc_removeKeyboardObserver {
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

@end

@implementation UITextField (LCKeyboardObserver)
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self lc_removeKeyboardObserver];
        [self lc_setKeyboardObserver:nil];
    }
}
@end

@implementation UITextView (LCKeyboardObserver)
- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    if (!newSuperview) {
        [self lc_removeKeyboardObserver];
        [self lc_setKeyboardObserver:nil];
    }
}
@end

