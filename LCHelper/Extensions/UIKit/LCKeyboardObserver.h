//
//  LCKeyboardObserver.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCKeyboardObserver : NSObject

- (instancetype)initWithObserveView:(UIView *)observeView transformView:(UIView *)transformView;

- (void)removeObserver;

@end
