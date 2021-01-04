//
//  UIActionSheet+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/5/6.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (LCHelp)<UIActionSheetDelegate>

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

+ (instancetype)actionSheetWithTitle:(NSString *)title buttonIndex:(void (^)(NSInteger index))buttonIndex cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end

