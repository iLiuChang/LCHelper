//
//  FirstViewController.m
//  LCHelperDemo
//
//  Created by 刘畅 on 2019/4/25.
//  Copyright © 2019 LiuChang. All rights reserved.
//

#import "FirstViewController.h"
#import "LCHelper.h"

@interface FirstViewController ()<UICollectionViewDataSource>
{
    NSInteger count;
}
@property (nonatomic, weak) UICollectionView *tableView;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.itemSize = CGSizeMake(100, 100);
    layout.minimumInteritemSpacing = 20;
    layout.minimumLineSpacing = 20;
    UICollectionView *tableView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, self.view.lc_width, 150) collectionViewLayout:layout];
    tableView.dataSource = self;
    [tableView registerClass:UICollectionViewCell.class forCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class)];
    tableView.backgroundColor = UIColor.whiteColor;
    [self.view addSubview:tableView];
    self.tableView = tableView;
    
    tableView.lc_refreshActivityIndicatorStyle = UIActivityIndicatorViewStyleLarge;
 
    tableView.lc_refreshScrollDirection = LCRefreshScrollDirectionHorizontal;
    __weak __typeof(self) weakSelf = self;
    [tableView lc_addHeaderRefreshingWithActionHandler:^{
        [weakSelf reload:YES];

    }];
    [tableView lc_addFooterRefreshingWithActionHandler:^{
        [weakSelf reload:NO];
    }];
    [tableView lc_beginFooterRefreshing];

    
}

- (void)reload:(BOOL)header {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (header) {
            self->count=10;
        } else {
            self->count+=10;

        }
        [self.tableView lc_endRefreshing];

        [self.tableView reloadData];
        
        
    });


}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(UICollectionViewCell.class) forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return count;

}


- (void)dealloc {
    NSLog(@"FirstViewController dealloc");
}
@end
