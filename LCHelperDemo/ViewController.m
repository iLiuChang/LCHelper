//
//  ViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 16/8/3.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "ViewController.h"
#import "FirstViewController.h"
#import "KeyboardViewController.h"
#import "UIActionSheet+LCHelp.h"
@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *dic = @{
//                          @"我是中文字符": @"223333",
//                          @"aaa": @{
//                                  @"aaa": @"啦啦啦"
//                                  }
//                          };
//    NSLog(@"%@", dic);

    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    KeyboardViewController *vc = [[KeyboardViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
    [[UIActionSheet actionSheetWithTitle:@"232" buttonIndex:^(NSInteger index) {
                NSLog(@"%ld", index);

    } cancelButtonTitle:@"取消" otherButtonTitles:@"1",@"2", nil] showInView:self.view] ;
 
//    [[UIAlertView alertWithTitle:@"提示" message:@"好的" buttonIndex:^(NSInteger index) {
//        NSLog(@"%ld", index);
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"其他", @"开始", nil] show] ;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
