//
//  MoreStoryViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "MoreStoryViewController.h"
#import "UIView+Common.h"
#import "MoreStoryCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "AllUrl.h"
#import "ListStoryModel.h"
#import "StoryDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
@interface MoreStoryViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
}

@end

@implementation MoreStoryViewController

- (void)viewDidLoad {
    self.titleString = @"精选故事";
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createCollectionView];
    _dataArray = [NSMutableArray new];
    [self loadNetData:NO];
}
- (void)createCollectionView {
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[self createLayout]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    
    MJRefreshBackFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [self loadNetData:YES];
    }];
    _collectionView.mj_footer = footer;
    
}
- (void)loadNetData:(BOOL)isMore {
    
    if (!isMore) {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    
    NSString *url  = [NSString stringWithFormat:STORYURL,(unsigned long)_dataArray.count];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        ListStoryModel  *model = [[ListStoryModel alloc] initWithData:responseObject error:nil];
        
        [_dataArray addObjectsFromArray:model.data.hot_spot_list];
        
        [_collectionView.mj_footer endRefreshing];
        
        [_collectionView reloadData];
        
        if (!isMore) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_collectionView.mj_footer endRefreshing];
    }];
}

- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake((screenWidth() - 30)/2, 160);
    layout.sectionInset = UIEdgeInsetsMake(20,10,20,10);
    return layout;
}

#pragma mark UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *fier = @"cellId";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"MoreStoryCollectionViewCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:fier ];
        nibsRegistered = YES;
    }
    MoreStoryCollectionViewCell *cell = (MoreStoryCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:fier forIndexPath:indexPath];
    cell.model = _dataArray[indexPath.row];
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    StoryDetailViewController *storyDetailViewController = [[StoryDetailViewController alloc] init];
    HotSpotListModel *model = _dataArray[indexPath.row];
    storyDetailViewController.model = model;
    [self.navigationController pushViewController:storyDetailViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
