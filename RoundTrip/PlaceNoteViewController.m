//
//  PlaceNoteViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/4.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceNoteViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "PlaceTripItemModel.h"
#import <MJRefresh/MJRefresh.h>
#import "TravelNoteDetailController.h"
#import <MJRefresh/MJRefreshBackFooter.h>
#import "PlaceNotesCell.h"
#import "HomeDataModel.h"

@interface PlaceNoteViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation PlaceNoteViewController

- (void)viewWillAppear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataSourceArray = [[NSMutableArray alloc] init];
    CGRect frame = self.view.bounds;
    frame.origin.y += 74;
    frame.size.height -= 74;
    _tableView.frame = frame;
}
- (void)createRefresh {
    MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadNetData:YES];
    }];
    _tableView.mj_footer = footer;
}
- (void)loadNetData:(BOOL)isMore {
    
    NSString *url = [NSString stringWithFormat:@"%@%ld",_keyString,(unsigned long)_dataSourceArray.count];
    [_manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PlaceTripItemModel *model = [[PlaceTripItemModel alloc] initWithData:responseObject error:nil];
        [_dataSourceArray addObjectsFromArray:model.items];
        [_tableView reloadData];
        [_tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *fier = @"fier";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"PlaceNotesCell" bundle:nil];
        [tableView  registerNib:nib forCellReuseIdentifier:fier];
        nibsRegistered = YES;
    }
    PlaceNotesCell *cell = (PlaceNotesCell *)[tableView dequeueReusableCellWithIdentifier:fier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = _dataSourceArray[indexPath.row];;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TravelNoteDetailController *noteDetailController = [[TravelNoteDetailController alloc] init];
    ItemModel *trip = _dataSourceArray[indexPath.row];
    noteDetailController.model = trip;
    [self.navigationController pushViewController:noteDetailController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 200;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
