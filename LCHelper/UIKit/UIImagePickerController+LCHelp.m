//
//  UIImagePickerController+LCHelp.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/6/5.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "UIImagePickerController+LCHelp.h"
#import <objc/runtime.h>

@implementation UIImagePickerController (LCHelp)

static const char LCUIImagePickerControllerFinishKey = '\0';
- (void)setFinishBlock:(void (^)(NSDictionary *info))finish{
    objc_setAssociatedObject(self, &LCUIImagePickerControllerFinishKey, finish, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)(NSDictionary *info))finishBlock{
    return objc_getAssociatedObject(self, &LCUIImagePickerControllerFinishKey);
}

static const char LCUIImagePickerControllerCancelKey = '\0';
- (void)setCancelBlock:(void (^)())cancel{
    objc_setAssociatedObject(self, &LCUIImagePickerControllerCancelKey, cancel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void (^)())cancelBlock{
    return objc_getAssociatedObject(self, &LCUIImagePickerControllerCancelKey);
}

+ (UIImagePickerController *)lc_imagePickerWithFinishHandler:(void (^)(NSDictionary *))finishHandler {
    return [self lc_imagePickerWithFinishHandler:finishHandler cancelHandler:nil];
}

+ (UIImagePickerController *)lc_imagePickerWithFinishHandler:(void (^)(NSDictionary *))finishHandler cancelHandler:(void (^)())cancelHandler {
    UIImagePickerController *vc = [[UIImagePickerController alloc] init];
    vc.delegate = vc;
    if (finishHandler) {
        [vc setFinishBlock:finishHandler];
    }
    if (cancelHandler) {
        [vc setCancelBlock:cancelHandler];
    }
    return vc;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self finishBlock]) {
        [self finishBlock](info);
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    if ([self cancelBlock]) {
        [self cancelBlock]();
    }
}

@end
