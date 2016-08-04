//
//  LCKeyboardManager.h
//  LCOCExtension
//
//  Created by 刘畅 on 16/8/2.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "LCSingleton.h"
@interface LCKeyboardManager : NSObject

/**
 *  距离键盘的间隔，默认为10
 */
@property(nonatomic, assign) CGFloat insterval;

SingletonH(Manager);

/**
 *  添加键盘监听
 *  @warning: 如果在view上监听多个视图，必须在开始编辑的时候监听
 *
 *  @param rect 需要监听视图的frame
 *  @param view 要改变frame的视图
 */
-(void)addKeyboardObserver:(CGRect)rect
                    toView:(UIView *)view;
@end
