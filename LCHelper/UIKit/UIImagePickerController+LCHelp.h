//
//  UIImagePickerController+LCHelp.h
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/6/5.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (LCHelp)<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

+ (UIImagePickerController *)lc_imagePickerWithFinishHandler:(void (^)(NSDictionary *info))finishHandler;

+ (UIImagePickerController *)lc_imagePickerWithFinishHandler:(void (^)(NSDictionary *))finishHandler cancelHandler:(void (^)(void))cancelHandler;
@end
