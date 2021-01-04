//
//  UIActionSheet+LCHelp.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIActionSheet+LCHelp.h"
#import <objc/runtime.h>

@implementation UIActionSheet (LCHelp)

static const char LCUIActionSheetKey = '\0';

- (void)setSelectBlock:(void (^)(NSInteger index))select{
    objc_setAssociatedObject(self, &LCUIActionSheetKey, select, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(NSInteger index))selectBlock{
    return objc_getAssociatedObject(self, &LCUIActionSheetKey);
}

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:nil otherButtonTitles:nil];
    sheet.selectBlock =buttonIndex;
    sheet.delegate = sheet;
    
    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
        [sheet addButtonWithTitle:str];
    }
    va_end(args);
    
    return sheet;
}

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION {
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    sheet.selectBlock =buttonIndex;
    sheet.delegate = sheet;

    va_list args;
    va_start(args, otherButtonTitles);
    for (NSString *str = otherButtonTitles; str != nil; str = va_arg(args,NSString*)) {
        [sheet addButtonWithTitle:str];
    }
    va_end(args);

    return sheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([self selectBlock] != nil) {
        [self selectBlock](buttonIndex);
    }
}
@end
