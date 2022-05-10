//
//  UIView+LCKeyboardObserver.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCKeyboardObserver)

- (void)lc_addKeyboardObserver;

- (void)lc_addKeyboardObserverWithSpacing:(CGFloat)keyboardSpacing;

- (void)lc_removeKeyboardObserver;

@end
