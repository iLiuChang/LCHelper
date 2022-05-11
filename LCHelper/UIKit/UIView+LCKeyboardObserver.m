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

@property(nonatomic, weak) UIView *transformView;

@property(nonatomic, weak) UIView *currentTextInput;

@end

@implementation LCKeyboardObserver

- (instancetype)initWithTransformView:(UIView *)transformView
{
    self = [super init];
    if (self) {
        self.transformView = transformView;
        [self addKeyboardObserver];
    }
    return self;
}

- (void)addKeyboardObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextFieldTextDidBeginEditingNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidEndEditing:) name:UITextFieldTextDidEndEditingNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidBeginEditing:) name:UITextViewTextDidBeginEditingNotification object:nil];
    [center addObserver:self selector:@selector(textInputDidEndEditing:) name:UITextViewTextDidEndEditingNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)note{
    UIView *observerView = self.currentTextInput;
    if (!observerView) {
        return;
    }
    CGRect convertRect = [observerView convertRect:observerView.bounds toView:self.transformView.window];

    CGFloat telMaxY = CGRectGetMaxY(convertRect);
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = [UIScreen mainScreen].bounds.size.height - keyboardH;
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration < 0.0){
        duration = 0.25;
    };
    if (telMaxY > keyboardY) {
        [UIView animateWithDuration:duration animations:^{
            self.transformView.transform = CGAffineTransformMakeTranslation(0,  keyboardY - telMaxY - self.keyboardSpacing);
        }];
    }
}

-(void)keyboardWillHide:(NSNotification *)note{
    if (!self.currentTextInput) {
        return;
    }

    double duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.transformView.transform = CGAffineTransformIdentity;
    }];
}

-(void)textInputDidBeginEditing:(NSNotification *)note {
    self.currentTextInput = note.object;
}

-(void)textInputDidEndEditing:(NSNotification *)note {
    self.currentTextInput = nil;
}

- (void)dealloc {
    [self removeObserver];
}

-(void)removeObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end

@implementation UIView (LCKeyboardObserver)

- (void)lc_addKeyboardObserver {
    [self lc_addKeyboardObserverWithSpacing:0];
}

- (void)lc_addKeyboardObserverWithSpacing:(CGFloat)keyboardSpacing {
    LCKeyboardObserver *observer = [[LCKeyboardObserver alloc] initWithTransformView:self];
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


