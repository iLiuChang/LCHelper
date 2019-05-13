//
//  UIAlertView+LCHelp.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIAlertView+LCHelp.h"
#import <objc/runtime.h>

@implementation UIAlertView (LCHelp)

static const char LCUIAlertViewKey = '\0';

- (void)setSelectBlock:(void (^)(NSInteger index))select{
    objc_setAssociatedObject(self, &LCUIAlertViewKey, select, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(NSInteger index))selectBlock{
    return objc_getAssociatedObject(self, &LCUIAlertViewKey);
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex buttonTitles:(NSString *)buttonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    alert.selectBlock =buttonIndex;
    alert.delegate = alert;
    
    va_list args;
    va_start(args, buttonTitles);
    for (NSString *str = buttonTitles; str != nil; str = va_arg(args,NSString*)) {
        [alert addButtonWithTitle:str];
    }
    va_end(args);
    
    return alert;
}

+ (instancetype)alertWithTitle:(NSString *)title message:(NSString *)message buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION{
    UIAlertView *alert =[[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:cancelButtonTitle otherButtonTitles:nil];
    alert.selectBlock =buttonIndex;
    alert.delegate = alert;
    
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
        [alert addButtonWithTitle:str];
    }
    va_end(args);
    
    return alert;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if ([self selectBlock] !=nil) {
        [self selectBlock](buttonIndex);
    }
}

@end
