//
//  PictureViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PictureViewController.h"
#import "UIView+Common.h"
#import "MoreStoryCollectionViewCell.h"
#import <AFNetworking/AFNetworking.h>
#import "AllUrl.h"
#import "PicModel.h"
#import "StoryDetailViewController.h"
#import <MJRefresh/MJRefresh.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "PicCollectionViewCell.h"
#import "TravelNoteDetailController.h"
#import "HomeDataModel.h"
#import "PlaceTripItemModel.h"
@interface PictureViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>{
    NSMutableArray *_dataArray;
    UICollectionView *_collectionView;
}

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createCollectionView];
    _dataArray = [NSMutableArray new];
    [self loadNetData:NO];
}
- (void)createCollectionView {
    CGRect frame = self.view.bounds;
    frame.origin.y +=64;
    frame.size.height -=64;
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
    NSString *url  = [NSString stringWithFormat:PICTURL,_typeString,(unsigned long)_dataArray.count];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PicModel  *model = [[PicModel alloc] initWithData:responseObject error:nil];
        [_dataArray addObjectsFromArray:model.items];
        [_collectionView reloadData];
        if (!isMore) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }
        [_collectionView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [_collectionView.mj_footer endRefreshing];
    }];
}

- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    layout.sectionInset = UIEdgeInsetsMake(10,5,10,5);
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
        UINib *nib = [UINib nibWithNibName:@"PicCollectionViewCell" bundle:nil];
        [collectionView registerNib:nib forCellWithReuseIdentifier:fier ];
        nibsRegistered = YES;
    }
    PicCollectionViewCell *cell = (PicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:fier forIndexPath:indexPath];
    PicInfoModel *model = _dataArray[indexPath.row];
    cell.picUrl = model.photo_s;
    return cell;
}
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TravelNoteDetailController *noteDetailController= [[TravelNoteDetailController alloc]init];
    PicInfoModel *pmodel = _dataArray[indexPath.row];
    ItemModel *model = [[ItemModel alloc] init];
    model.cover_image =  pmodel.photo_s;
    model.eid = pmodel.trip_id;
    model.name = pmodel.trip_name;
    noteDetailController.model = model;
    [self.navigationController pushViewController:noteDetailController animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {

  return CGSizeMake((screenWidth() - 20)/3, (screenWidth() - 20)/3);

}


@end
