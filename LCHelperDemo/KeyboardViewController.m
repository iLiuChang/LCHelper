//
//  KeyboardViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/29.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "KeyboardViewController.h"
#import "UITextField+LCKeyboardObserver.h"

@interface KeyboardViewController ()
@property(nonatomic, weak) UITextField *textField;
@end

@implementation KeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UITextField *t = [[UITextField alloc] init];
    t.frame = CGRectMake(100, self.view.frame.size.height - 300, 100, 50);
    t.backgroundColor = [UIColor redColor];
    [self.view addSubview:t];
    [t addKeyboardObserver];
    
    UITextField *t2 = [[UITextField alloc] init];
    t2.frame = CGRectMake(100, self.view.frame.size.height - 200, 100, 50);
    t2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:t2];
    [t2 addKeyboardObserver];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"KeyboardViewController deinit");
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
