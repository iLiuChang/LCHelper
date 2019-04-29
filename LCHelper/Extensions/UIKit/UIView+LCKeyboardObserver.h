//
//  UIView+LCKeyboardObserver.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (LCKeyboardObserver)

/**
 添加键盘观察者
 */
- (void)addKeyboardObserver;

/**
 添加键盘观察者

 @param view 要改变的视图, 为空为父视图
 */
- (void)addKeyboardObserverWithTransformView:(UIView *)view;

/**
 添加键盘观察者

 @param view 要改变的视图, 为空为父视图
 @param keyboardSpacing 距离键盘的距离
 */
- (void)addKeyboardObserverWithTransformView:(UIView *)view keyboardSpacing:(CGFloat)keyboardSpacing;

/**
 移除键盘观察者, UITextField和UITextView会自动移除
 */
- (void)removeKeyboardObserver;

@end

@interface UITextField (LCKeyboardObserver)

@end

@interface UITextView (LCKeyboardObserver)

@end
