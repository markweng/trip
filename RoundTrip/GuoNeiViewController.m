//
//  GuoNeiViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/25.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "GuoNeiViewController.h"
#import "AllUrl.h"
#import <AFNetworking/AFNetworking.h>
#import "PlaceDataModel.h"
#import "GuoNeiViewCell.h"
#import "UIView+Common.h"
#import "PlaceDetailController.h"


@interface GuoNeiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    
}
@property (nonatomic) CGFloat standardHeight;
@property (nonatomic) CGFloat focusedHeight;
@property (nonatomic) CGFloat dragOffset;
@end

@implementation GuoNeiViewController
- (void)viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES];
    NSString *backArrowString = @"返回";
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:backArrowString style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem =  backBarButtonItem;
}
- (void)viewDidLoad {
    self.titleString = @"大陆城市";
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    [self createCollectionView];
    [self loadNetData];
    
    
}
- (void)createCollectionView {
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:[self createLayout]];
    
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass: [GuoNeiViewCell class]forCellWithReuseIdentifier:@"fier"];
    [self.view addSubview:_collectionView];
}
- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    layout.itemSize = CGSizeMake(screenWidth() - 20, 160);
    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    return layout;
}
- (void)loadNetData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:PLAYCEURL,8];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        PlaceDataModel *model = [[PlaceDataModel alloc] initWithData:responseObject error:nil];
        [_dataArray addObjectsFromArray:model.data];
        [_collectionView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error description]);
    }];
}
#pragma  mark UICollectionViewDataSource methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return _dataArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GuoNeiViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fier" forIndexPath:indexPath];
    CGFloat yOffset = ((_collectionView.contentOffset.y - cell.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
    cell.imageOffset = CGPointMake(0.0f, yOffset);
    cell.model = _dataArray[indexPath.row];
    return cell;
}
#pragma mark UICollectionViewDelegate methods
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    PlaceDetailController *vc = [[PlaceDetailController alloc] init];
    vc.model = _dataArray[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    for(GuoNeiViewCell *view in _collectionView.visibleCells) {
        CGFloat yOffset = ((_collectionView.contentOffset.y - view.frame.origin.y) / IMAGE_HEIGHT) * IMAGE_OFFSET_SPEED;
        view.imageOffset = CGPointMake(0.0f, yOffset);
    }
}


@end
