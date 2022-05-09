//
//  FirstViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/25.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "FirstViewController.h"
#import "UIScrollView+LCRefresh.h"

@interface FirstViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSInteger count;
}
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = self.view.bounds;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 100;
    [tableView registerClass:UITableViewCell.class forCellReuseIdentifier:@"cell"];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.lc_refreshActivityIndicatorStyle = UIActivityIndicatorViewStyleLarge;
 
    __weak __typeof(self) weakSelf = self;
    [tableView lc_addHeaderRefreshingWithActionHandler:^{
        [weakSelf reload:YES];

    }];
    [tableView lc_beginHeaderRefreshing];
    [tableView lc_addFooterRefreshingWithActionHandler:^{
        [weakSelf reload:NO];
    }];
    
}

- (void)reload:(BOOL)header {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (header) {
            self->count=10;
        } else {
            self->count+=10;

        }
        [self.tableView reloadData];
        
        [self.tableView lc_endRefreshing];
        
    });

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return count;
}

- (void)dealloc {
    NSLog(@"FirstViewController dealloc");
}
@end
