//
//  GangAotaiControllerViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/4.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "GangAotaiControllerViewController.h"
#import "AllUrl.h"
#import <AFNetworking/AFNetworking.h>
#import "PlaceDataModel.h"
#import "GuoNeiViewCell.h"
#import "UIView+Common.h"
#import "PlaceDetailController.h"
#import "WantPlaceModel.h"


@interface GangAotaiControllerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    UICollectionView *_collectionView;
    NSMutableArray *_dataArray;
    
}
@property (nonatomic) CGFloat standardHeight;
@property (nonatomic) CGFloat focusedHeight;
@property (nonatomic) CGFloat dragOffset;
@end

@implementation GangAotaiControllerViewController

- (void)viewDidLoad {
    self.titleString = @"港澳台";
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    [self createCollectionView];
    [self loadNetData];
    
    
}
- (void)createCollectionView {
    _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:[self createLayout]];
    _collectionView.backgroundColor = [UIColor whiteColor];
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _collectionView.frame = frame;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass: [GuoNeiViewCell class]forCellWithReuseIdentifier:@"fier"];
    [self.view addSubview:_collectionView];
}
- (UICollectionViewLayout *)createLayout {
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(screenWidth() - 20, 160);
    layout.sectionInset = UIEdgeInsetsMake(10,10,10,10);
    return layout;
}
- (void)loadNetData {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
  
    [manager GET:WANTPLACEURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        WantPlaceModel *model = [[WantPlaceModel alloc] initWithData:responseObject error:&error];
        for (PlaceElementModel *pmodel in model.elements) {
            if ([pmodel.title isEqualToString:@"港澳台"]) {
                [_dataArray addObjectsFromArray:pmodel.data];
                break;
            }
        }
        
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
