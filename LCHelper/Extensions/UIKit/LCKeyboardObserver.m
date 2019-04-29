//
//  LCKeyboardObserver.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "LCKeyboardObserver.h"

@interface LCKeyboardObserver()

@property(nonatomic, weak) UIView *observeView;

@property(nonatomic, weak) UIView *transformView;

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
        self.observeView = observeView;
        self.transformView = transformView;
        if (!self.transformView) {
            self.transformView = observeView.superview;
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
            self.transformView.transform = CGAffineTransformMakeTranslation(0,  keyboardY - telMaxY - 20);
        }else {
            self.transformView.transform = CGAffineTransformIdentity;
        }
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)note{
    if (!self.observeView.isFirstResponder) {
        return;
    }
    double duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.transformView.transform = CGAffineTransformIdentity;
    }];
}

-(void)removeObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
@end
