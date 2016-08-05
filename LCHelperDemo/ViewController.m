//
//  ViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 16/8/3.
//  Copyright © 2016年 LiuChang. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSDictionary *dic = @{
                          @"我是中文字符": @"223333",
                          @"aaa": @{
                                  @"aaa": @"啦啦啦"
                                  }
                          };
    NSLog(@"%@", dic);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
