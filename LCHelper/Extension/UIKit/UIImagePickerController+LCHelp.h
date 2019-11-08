//
//  UIImagePickerController+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/6/5.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (LCHelp)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

+ (UIImagePickerController *)imagePickerWithFinishHandler:(void (^)(NSDictionary *info))finishHandler;

+ (UIImagePickerController *)imagePickerWithFinishHandler:(void (^)(NSDictionary *))finishHandler cancelHandler:(void (^)())cancelHandler;
@end
