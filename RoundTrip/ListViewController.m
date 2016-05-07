//
//  ListViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "ListViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJRefresh/MJRefresh.h>
@interface ListViewController ()<UITableViewDataSource,UITableViewDelegate>{

}
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createDataSource];
    [self createTableView];
    [self initRequestManager];
    [self initData];
    self.view.backgroundColor = [UIColor whiteColor];

}
- (void)createDataSource{}
//createData
- (void)initData {
    [self loadNetData:NO];
}
- (void)initRequestManager {
    if (_manager == nil) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
}
- (void)createTableView {
    if (_tableView == nil) {
        _tableView= [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    [self createRefresh];
}
- (void) createRefresh {
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadNetData:NO];
    }];
    _tableView.mj_header = header;
    
    MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadNetData:YES];
    }];
    _tableView.mj_footer = footer;

}

- (void)loadNetData:(BOOL)isMore {

}
#pragma mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    return nil;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _tableView)
    {
        CGFloat sectionHeaderHeight = 50;
        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
        }
    }
}
@end
