//
//  UIAlertView+LCHelp.h
//  LCHelper (https://github.com/iLiuChang/LCHelper)
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (LCHelp)

+ (instancetype)lc_alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)lc_alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end

