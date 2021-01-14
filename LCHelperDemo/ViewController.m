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
#import "LCHelper.h"

@interface ViewController ()
@property (nonatomic, strong) NSArray *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [sv reloadData];
//    });
    
    [self.view lc_addTapGestureRecognizer:^{
        NSLog(@"single tap");
    }];
    
    [self.view lc_addDoubleTapGestureRecognizer:^{
        NSLog(@"double tap");
    }];

    [[UIAlertView lc_alertWithTitle:@"nihao" message:nil buttonIndex:nil buttonTitles:@"12", nil] show];
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    FirstViewController *vc = [[FirstViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//    [[UIActionSheet actionSheetWithTitle:@"232" buttonIndex:^(NSInteger index) {
//                NSLog(@"%ld", index);
//
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"1",@"2", nil] showInView:self.view] ;
 
//    [[UIAlertView alertWithTitle:@"提示" message:@"好的" buttonIndex:^(NSInteger index) {
//        NSLog(@"%ld", index);
//    } cancelButtonTitle:@"取消" otherButtonTitles:@"其他", @"开始", nil] show] ;
    
//    self.images = @[[UIImage imageWithColor:[UIColor redColor] size:CGSizeMake(20, 20)],
//                    [UIImage imageWithColor:[UIColor yellowColor] size:CGSizeMake(20, 20)],
//                    [UIImage imageWithColor:[UIColor magentaColor] size:CGSizeMake(20, 20)]];
//
//    [self.scrollView reloadData];
    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
