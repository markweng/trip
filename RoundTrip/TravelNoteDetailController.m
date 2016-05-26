//
//  TravelNoteDetailController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "TravelNoteDetailController.h"
#import <AFNetworking/AFNetworking.h>
#import "TravelNotesModel.h"
#import "TravelNotesCell.h"
#import "TravelNotesCellFrame.h"
#import "AllUrl.h"
#import "UIView+Common.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <UIImageView+WebCache.h>
#import "HomeDataModel.h"
#import "PlaceTripItemModel.h"
#import "DBManager.h"
#import "ScrollViewController.h"
#import "UMSocial.h"
#import <BmobSDK/Bmob.h>

@interface TravelNoteDetailController ()<UITableViewDataSource,UITableViewDelegate,UMSocialUIDelegate> {
    UITableView *_tableView;
    NSMutableArray *_groupArray;
    NSMutableArray *_dataArray;
    NSMutableArray *_aryData;
}
@property (nonatomic, strong) UIImage *shareImage;
@end

@implementation TravelNoteDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"游记详情";

    _dataArray = [NSMutableArray new];
    _groupArray = [NSMutableArray new];
    _aryData = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createLikeButton];
    [self createTableView];
    [self loadNetData];
}
- (void)createLikeButton {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(screenWidth() - 40, 30, 24, 24);
    BOOL isExistRecord = [[DBManager sharedManager] isExistInfoForid:nil tripid:_model.eid];
    [self setFavouriteButton:button isFavourete:isExistRecord];
    [button addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(screenWidth() - 80, 28, 28, 28);
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"share1"] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.model.cover_image_default] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        weakSelf.shareImage = image;
    }];


}
- (void)shareAction {
    
    NSString *url = [NSString stringWithFormat:@"http://web.breadtrip.com/%@?",self.model.share_url];
    NSString *shareText;
    if (self.model.text) {
        shareText = [NSString stringWithFormat:@"%@ http://web.breadtrip.com/%@?",self.model.text,self.model.share_url];
    } else {
    
       shareText = @"来自时光旅行的分享：";
    
    }
    
    [UMSocialData defaultData].extConfig.title = self.model.text;
    [UMSocialData defaultData].extConfig.sinaData.urlResource.url = url;
    [UMSocialData defaultData].extConfig.wechatSessionData.url = url;
    [UMSocialData defaultData].extConfig.wechatTimelineData.url = url;
    [UMSocialData defaultData].extConfig.qzoneData.url = url;
    [UMSocialData defaultData].extConfig.qqData.url = url;
    [UMSocialSnsService presentSnsIconSheetView:self appKey:UMENG_SHAREKEY
                                      shareText:shareText shareImage:_shareImage shareToSnsNames:@[UMShareToSina,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToWechatSession,UMShareToWechatTimeline,UMShareToQQ,UMShareToFacebook,UMShareToTwitter]
                                       delegate:self];
}

- (void)setFavouriteButton:(UIButton *)button isFavourete:(BOOL)isFavourete {
    
    UIImage *favoriteImage = [[UIImage imageNamed:@"iconfont-iconfontlike"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *noFavoriteImage =  [UIImage imageNamed:@"iconfont-dianzan"];
    [button setImage:isFavourete?favoriteImage:noFavoriteImage forState:UIControlStateNormal];
    
}
- (void)likeAction:(UIButton *)button {
    BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {
        [self showHudWithTitle:@"请先登录"];
        return;
    }

    BOOL isExistRecord = [[DBManager sharedManager] isExistInfoForid:nil tripid:_model.eid];
    if (isExistRecord) {
     [[DBManager sharedManager] deleteModelForTripid:_model.eid];
        isExistRecord = NO;
    }else{
        [[DBManager sharedManager] insertTripModel:_model];
        isExistRecord = YES;
    }
    [self setFavouriteButton:button isFavourete:isExistRecord];
}
- (void)createTableView {
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)loadNetData {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:TRAVELNOTEURL,_model.eid];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
        
        TravelNotesModel *travelNotesModel = [[TravelNotesModel alloc] initWithData:responseObject error:nil];
        for (DaysModel *model in travelNotesModel.days) {
            NSString *dateString = [NSString stringWithFormat:@"第 %@ 天 %@",model.day,model.date];
            [_groupArray addObject:dateString];
            NSMutableArray *modelarray = [NSMutableArray new];
            NSMutableArray *nextViewModel = [NSMutableArray new];
            for (WaypointsModel *wayPoiModel in model.waypoints) {
                TravelNotesCellFrame *cellFrame = [[TravelNotesCellFrame alloc] init];
                cellFrame.model = wayPoiModel;
                [modelarray addObject:cellFrame];
            }
            [_aryData addObject:nextViewModel];
            [_dataArray addObject:modelarray];
        }
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    }];
}
#pragma mark datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _groupArray.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _dataArray[section];
    return array.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    TravelNotesCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[TravelNotesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellFrame = _dataArray[indexPath.section][indexPath.row];
    return cell;
    
}
#pragma mark delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelNotesCellFrame *frame = _dataArray[indexPath.section][indexPath.row];
    return frame.cellHeight;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     CGFloat leftPadding = 25;
    UIView *view = [[UIView alloc] init];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(9, 9, 32, 32);
    imageView.image = [UIImage imageNamed:@"dateIcon"];
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.frame = CGRectMake(50, 10, screenWidth() - 50 - 10, 30);
    dateLabel.text = _groupArray[section];
    dateLabel.font = [UIFont systemFontOfSize:25];
    
    [view addSubview:dateLabel];

     UILabel * lineLabel = [[UILabel alloc] init];
    if (section == 0) {
       
        lineLabel.frame = CGRectMake(leftPadding - 2, getMaxY(imageView)-2, 4, 50-getMaxY(imageView)+2);
        
    } else {
        lineLabel.frame = CGRectMake(leftPadding - 2, 0, 4, 50-getMaxY(imageView)+2);
    }
    lineLabel.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:0.8];
    [view addSubview:lineLabel];
    [view addSubview:imageView];
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    TravelNotesCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ScrollViewController *svc = [[ScrollViewController alloc] init];
    svc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    svc.bgImage = cell.largeImageView.image;
    [self presentViewController:svc animated:YES completion:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}
@end
