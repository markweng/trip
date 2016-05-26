//
//  StoryDetailViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "AllUrl.h"
#import "StoryDetailModel.h"
#import "StoryDetialViewCell.h"
#import "StoryDetialViewCellFrame.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "NSString+Commom.h"
#import "UIView+Common.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "DBManager.h"
#import "ListStoryModel.h"
#import "ScrollViewController.h"
#import "UMSocial.h"
#import <BmobSDK/Bmob.h>

#define Font [UIFont systemFontOfSize:20]
@interface StoryDetailViewController ()<UITableViewDataSource, UITableViewDelegate, UMSocialUIDelegate>{
    
    NSMutableArray *_dataSourceArray;
    UITableView *_tableView;
    UserDetailModel *_userModel;
    SpotModel *_spotModel;
    CGFloat _headHeight;
}

@end

@implementation StoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleString = @"故事详情";

    _dataSourceArray = [NSMutableArray new];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createRightButton];
    [self createTableView];
    [self loadDataFormNet];
}

- (void)createRightButton {
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(screenWidth() - 40, 30, 24, 24);
    BOOL isExistRecord = [[DBManager sharedManager] isExistInfoForid:_model.spot_id tripid:nil];
    [self setFavouriteButton:button isFavourete:isExistRecord];
    [button addTarget:self action:@selector(likeAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    shareButton.frame = CGRectMake(screenWidth() - 80, 28, 28, 28);
    [shareButton addTarget:self action:@selector(shareAction) forControlEvents:UIControlEventTouchUpInside];
    [shareButton setImage:[UIImage imageNamed:@"share1"] forState:UIControlStateNormal];
    [self.view addSubview:shareButton];
    
    __weak typeof(self) weakSelf = self;
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:self.model.index_cover] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        weakSelf.shareImage = image;
    }];

    
}
- (void)setFavouriteButton:(UIButton *)button isFavourete:(BOOL)isFavourete {
    
    UIImage *favoriteImage = [[UIImage imageNamed:@"iconfont-iconfontlike"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage *noFavoriteImage =  [UIImage imageNamed:@"iconfont-dianzan"];
    [button setImage:isFavourete?favoriteImage:noFavoriteImage forState:UIControlStateNormal];
    
}
- (void)shareAction {
    
    NSString *url = [NSString stringWithFormat:@"http://web.breadtrip.com/%@?",self.model.share_url];
    NSString *shareText = [NSString stringWithFormat:@"%@ http://web.breadtrip.com/%@?",self.model.text,self.model.share_url];
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
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        //得到分享到的平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}
- (void)likeAction:(UIButton *)button {
    BmobUser *user = [BmobUser getCurrentUser];
    if (!user) {
        [self showHudWithTitle:@"请先登录"];
        return;
    }
    BOOL isExistRecord = [[DBManager sharedManager] isExistInfoForid:_model.spot_id tripid:nil];
    if (isExistRecord) {
        [[DBManager sharedManager] deleteModelForPid:_model.spot_id];
        isExistRecord = NO;
    }else{
        [[DBManager sharedManager] insertModel:_model];
        isExistRecord = YES;
    }
    [self setFavouriteButton:button isFavourete:isExistRecord];
}
- (void)createTableView {
    if (_tableView == nil) {
        CGRect frame = self.view.bounds;
        frame.origin.y += 64;
        frame.size.height -= 64;
        _tableView= [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
}

- (void)loadDataFormNet {
    //显示 loading
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:STORYDETIALURL,_model.spot_id];
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        StoryDetailModel *detailmodel = [[StoryDetailModel alloc] initWithData:responseObject error:nil];
        _userModel = detailmodel.data.trip.user;
        _spotModel = detailmodel.data.spot;
        for ( DetailListModel *model in detailmodel.data.spot.detail_list) {
            StoryDetialViewCellFrame *cellFrame = [[StoryDetialViewCellFrame alloc] init];
            cellFrame.model = model;
            [_dataSourceArray addObject:cellFrame];
        }
        [_tableView reloadData];
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 隐藏 loading 提示框
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
    }];
}
#pragma mark dateSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSourceArray.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    StoryDetialViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[StoryDetialViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellFrame = _dataSourceArray[indexPath.row];
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryDetialViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ScrollViewController *svc = [[ScrollViewController alloc] init];
    svc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    svc.bgImage = cell.largeImageView.image;
    [self presentViewController:svc animated:YES completion:^{
        
    }];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    StoryDetialViewCellFrame *cellframe = _dataSourceArray[indexPath.row];
    return cellframe.cellHeight;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] init];
    CGFloat padding = 10.0;
    UIImageView *iconView = [[UIImageView alloc] init];
    [iconView sd_setImageWithURL:[NSURL URLWithString:_userModel.avatar_m] placeholderImage:nil];
    iconView.frame = CGRectMake(padding, padding, 40, 40);
    iconView.clipsToBounds = YES;
    iconView.layer.cornerRadius = 20;
    [view addSubview:iconView];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.frame = CGRectMake(getMaxX(iconView) + padding, 20, screenWidth() - getMaxX(iconView) - 2 * padding, 20);
    nameLabel.text  =  _userModel.name;
    [view addSubview:nameLabel];
    if (_spotModel.text.length > 0) {
        UILabel *textLabel = [[UILabel alloc] init];
        CGSize size = [_spotModel.text sizeWithFont:Font maxSize:CGSizeMake(screenWidth() - 2*padding, MAXFLOAT)];
        textLabel.frame = CGRectMake(padding, getMaxY(iconView) + padding, size.width, size.height);
        textLabel.font = Font;
        textLabel.text = _spotModel.text;
        textLabel.numberOfLines = 0;
        [view addSubview:textLabel];
    }
    return view;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 5, screenWidth(), 20);
    label.text = @"~";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = Font;
    [view addSubview:label];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGSize size = [_spotModel.text sizeWithFont:Font maxSize:CGSizeMake(screenWidth() - 2*10, MAXFLOAT)];
    
    return 60 + size.height;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
