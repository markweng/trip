//
//  SearchMoreTripsControllerViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "SearchMoreTripsControllerViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "SearchTravelNotesCell.h"
#import "SearchMoreModel.h"
#import <MJRefresh/MJRefresh.h>
#import "TravelNoteDetailController.h"
#import <MJRefresh/MJRefreshBackFooter.h>
#import "PlaceTripItemModel.h"

@interface SearchMoreTripsControllerViewController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SearchMoreTripsControllerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _dataSourceArray = [[NSMutableArray alloc] init];
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
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
        SearchMoreModel *model = [[SearchMoreModel alloc] initWithData:responseObject error:nil];
        [_dataSourceArray addObjectsFromArray:model.data.trips];
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
        UINib *nib = [UINib nibWithNibName:@"SearchTravelNotesCell" bundle:nil];
        [tableView  registerNib:nib forCellReuseIdentifier:fier];
        nibsRegistered = YES;
    }
    SearchTravelNotesCell *cell = (SearchTravelNotesCell *)[tableView dequeueReusableCellWithIdentifier:fier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TripsModel *trip = _dataSourceArray[indexPath.row];
    cell.model = trip;
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TravelNoteDetailController *noteDetailController = [[TravelNoteDetailController alloc] init];
    TripsModel *trip = _dataSourceArray[indexPath.row];
    ElementDataModel *model = [[ElementDataModel alloc] init];
    model.cover_image =  trip.cover_image_default;
    model.eid = trip.tid;
    model.name = trip.name;
    model.text = trip.name;
    model.index_cover = trip.cover_image_default;
    model.share_url = trip.share_url;
    noteDetailController.model = model;
    [self.navigationController pushViewController:noteDetailController animated:YES];
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
