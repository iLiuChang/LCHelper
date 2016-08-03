//
//  LCKeyboardManager.m
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/2.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "LCKeyboardManager.h"


@interface LCKeyboardManager()

@property(nonatomic, assign) CGRect frame;
@property(nonatomic, weak) UIView *changeView;

@end
@implementation LCKeyboardManager

static LCKeyboardManager *_keyboardManager = nil;
+ (instancetype)shareManager {
    static dispatch_once_t once;
    if (_keyboardManager) {
        dispatch_once(&once, ^{
            _keyboardManager = [[LCKeyboardManager alloc] init];
        });
    }
    return _keyboardManager;
}

-(void)addKeyboardObserver:(CGRect)rect toView: (UIView *)view {
    [self removeKeyboardObserver];
    [self addKeyboardObserver];
    self.frame = rect;
    self.changeView = view;
    
}

- (CGFloat)insterval {
    if (!_insterval) {
        _insterval = 10;
    }
    return _insterval;
}

-(void)addKeyboardObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)keyboardWillShow:(NSNotification *)note{
    CGFloat telMaxY = CGRectGetMaxY(self.frame);
    CGFloat keyboardH = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    CGFloat keyboardY = self.changeView.frame.size.height - keyboardH;
    double duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    if (duration < 0.0){
        duration = 0.25;
    };
    [UIView animateWithDuration:duration animations:^{
        if (telMaxY > keyboardY) {
            self.changeView.transform = CGAffineTransformMakeTranslation(0,  keyboardY - telMaxY - self.insterval);
        }else {
            self.changeView.transform = CGAffineTransformIdentity;
        }
    }];
    
}

-(void)keyboardWillHide:(NSNotification *)note{
    double duration  = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.changeView.transform = CGAffineTransformIdentity;
    }];
}

-(void)removeKeyboardObserver {
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [center removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc {
    [self removeKeyboardObserver];
}
@end
