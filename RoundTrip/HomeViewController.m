//
//  HomeViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/25.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "HomeViewController.h"
#import "AllUrl.h"
#import "HomeDataModel.h"
#import "UIView+Common.h"
#import "BannerViewCell.h"
#import "BannerdescViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "StoryViewCell.h"
#import "TeavelNotesViewCell.h"
#import "StoryDetailViewController.h"
#import "MoreStoryViewController.h"
#import "TravelNoteDetailController.h"
#import "MyCache.h"
#import <MJRefresh/MJRefresh.h>
#import "NSString+Commom.h"
#import "SearchViewController.h"
#import "SearchView.h"
#import "SearchMoreModel.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import "PlaceDetailController.h"
#import "GuoNeiViewController.h"
#import "GangAotaiControllerViewController.h"
#import "GuoWaiViewController.h"
#import "ListStoryModel.h"
@interface HomeViewController ()<UISearchBarDelegate,SearchViewDelegate>{
    HomeElementsModel *_elementModel;
    NSMutableArray *_storyModelAray;
    NSMutableArray *_travelNotesArray;
    NSString *_moreUrl;
    SearchView *_searchView;
    UISearchBar *_searchBar;
    UIButton *_rightButton;
    UIButton *_guoneiButton;
    UIButton *_guowaiButton;
    UIButton *_gangButton;
    UIButton *_controlButton;
    BOOL _buttonIshidden;
    
    
}
@property (nonatomic, strong) HomeModel *homeModel;
@end

@implementation HomeViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _tableView.frame = frame;
   
    [self reachability];
    [self createFloatButton];
    [self layoutViews];

}
- (void)createDataSource {

    _storyModelAray = [NSMutableArray array];
    _travelNotesArray = [NSMutableArray array];

}
- (void)createFloatButton {
    _controlButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _controlButton.frame = CGRectMake(15, screenHeight() - 64, 50, 50);
    [_controlButton setImage:[UIImage imageNamed:@"iconfont-chujingyoutu"] forState:UIControlStateNormal];
    _controlButton.layer.cornerRadius = 25;
    [_controlButton addTarget:self action:@selector(createMoreButton) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_controlButton];
    
}
- (void)initData {}
- (void)createMoreButton {
    
    
    if (_guoneiButton == nil) {
        _guoneiButton = [self createAButton:@"iconfont-guoneiremen" selctor:@selector(buttonAction:)];
        _guoneiButton.frame = _controlButton.frame;
        _guoneiButton.tag = 8001;
        _gangButton = [self createAButton:@"iconfont-gangaotai" selctor:@selector(buttonAction:)];
        _gangButton.frame = _controlButton.frame;
        _gangButton.tag = 8002;
        _guowaiButton = [self createAButton:@"iconfont-chujingyoum" selctor:@selector(buttonAction:)];
        _guowaiButton.tag = 8003;
        _guowaiButton.frame = _controlButton.frame;
        [self.view addSubview:_guowaiButton];
        [self.view addSubview:_gangButton];
        [self.view addSubview:_guoneiButton];
        _buttonIshidden = YES;
    }
    if (_buttonIshidden) {
        CGFloat width = 50;
        _guoneiButton.hidden = NO;
        _gangButton.hidden = NO;
        _guowaiButton.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _guoneiButton.frame = CGRectMake(15, screenHeight() - 64 - 100, width, width);
            _gangButton.frame = CGRectMake(0, 0, width, width);
            _gangButton.center = CGPointMake(70.7+15 + 25, screenHeight()-64+25-70.7);
            
            _guowaiButton.frame = CGRectMake(15+100, screenHeight() - 64, width, width);
        }];
        
        
        _buttonIshidden = NO;
    } else {
        
        [self hidenButton];
        
        _buttonIshidden = YES;
    }
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
    if (_buttonIshidden == NO) {
        [self hidenButton];
        _buttonIshidden = YES;
    }
    
}
- (void)hidenButton {
    [UIView animateWithDuration:0.3 animations:^{
        _guowaiButton.frame = _controlButton.frame;
        _gangButton.frame = _controlButton.frame;
        _guoneiButton.frame = _controlButton.frame;
        _guoneiButton.hidden = YES;
        _gangButton.hidden = YES;
        _guowaiButton.hidden = YES;
    }];
    
    
    
}
- (void)buttonAction:(UIButton *)button {
    
    switch (button.tag - 8000) {
        case 1:
        {
            GuoNeiViewController *guoNeiViewController = [[GuoNeiViewController alloc] init];
            [self.navigationController pushViewController:guoNeiViewController animated:YES];
        }
            break;
        case 2:
        {
            GangAotaiControllerViewController *gangViewController = [[GangAotaiControllerViewController alloc] init];
            [self.navigationController pushViewController:gangViewController animated:YES];
            
        }
            
            break;
        case 3:
        {
            GuoWaiViewController *guowaiViewController = [[GuoWaiViewController alloc] init];
            [self.navigationController pushViewController:guowaiViewController animated:YES];
            
        }
            
            break;
            
        default:
            break;
    }
    
}
- (UIButton *)createAButton:(NSString *)imageName selctor:(SEL)selctor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    button.layer.cornerRadius = 25;
    [button addTarget:self action:selctor forControlEvents:UIControlEventTouchUpInside];
    return  button;
    
}
- (void)layoutViews {
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _tableView.frame = frame;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor clearColor];
    
}
- (void)reachability
{
    // 检测网络连接状态
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    // 连接状态回调处理
    /* AFNetworking的Block内使用self须改为weakSelf, 避免循环强引用, 无法释放 */
    __weak typeof(self) weakSelf = self;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         switch (status)
         {
             case AFNetworkReachabilityStatusUnknown:
                 [weakSelf readCache];
                 break;
             case AFNetworkReachabilityStatusNotReachable:
                 [weakSelf readCache];
                 break;
             case AFNetworkReachabilityStatusReachableViaWWAN:
                 [weakSelf loadNetData:NO];
                 break;
             case AFNetworkReachabilityStatusReachableViaWiFi:
                 [weakSelf loadNetData:NO];
                 break;
             default:
                 break;
         }
     }];
}

- (void)readCache {
    NSData *cacheData = [MyCache objectForKey:MD5Hash(HomeUrl)];
    if (cacheData) {
        
        HomeModel *homeModel = [[HomeModel alloc] initWithData:cacheData error:nil];
        for (HomeElementsModel *model in homeModel.data.elements) {
            
            if ([model.type isEqualToString:@"1"]) {
                _elementModel = model;
            }
            
            if ([model.type isEqualToString:@"10"]) {
                
                ElementDataModel *storyModel = model.data[0];
                [_storyModelAray addObject:storyModel];
            }
            
            if ([model.type isEqualToString:@"4"]) {
                ElementDataModel *travelNotesModel = model.data[0];
                [_travelNotesArray addObject:travelNotesModel];
            }
        }
        [_tableView reloadData];
        [_tableView.mj_header endRefreshing];
        return;
    }
    return;
}
- (void)loadNetData:(BOOL)isMore {
    
    
    
    NSString *homeURL = nil;
    if (!isMore) {
       
        homeURL = HomeUrl;
        
    } else {
        homeURL = [NSString stringWithFormat:ISMOREURL,_moreUrl];
    }
    
    [_manager GET:homeURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        _homeModel = [[HomeModel alloc] initWithData:responseObject error:&error];
        if (!isMore) {
            [_storyModelAray removeAllObjects];
            [_travelNotesArray removeAllObjects];
        }
        _moreUrl = _homeModel.data.next_start;
        for (HomeElementsModel *model in _homeModel.data.elements) {
            if (!isMore) {
                
                if ([model.type isEqualToString:@"1"]) {
                    _elementModel = model;
                }
                
                if ([model.type isEqualToString:@"10"]) {
                    
                    ElementDataModel *storyModel = [model.data firstObject];
                    NSLog(@"%@",storyModel.text);
                    [_storyModelAray addObject:storyModel];
                }
                
                if ([model.type isEqualToString:@"4"]) {
//                    ElementDataModel *travelNotesModel = [model.data firstObject];
//                    [_travelNotesArray addObject:travelNotesModel];
                    [_travelNotesArray addObject:[model.data firstObject]];

                }
                [MyCache setObject:responseObject forKey:MD5Hash(HomeUrl)];
            } else {
                
                if ([model.type isEqualToString:@"4"]) {
                   // ElementDataModel *travelNotesModel = [model.data firstObject];
                    [_travelNotesArray addObject:[model.data firstObject]];
                }
            }
            [_tableView reloadData];
            
            isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
        }
      
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        isMore?[_tableView.mj_footer endRefreshing]:[_tableView.mj_header endRefreshing];
    }];
}
- (void)customNavigationBar {
    [self.navigationController setNavigationBarHidden:YES];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), 64)];
    view.backgroundColor = [UIColor colorWithRed:21/255.0 green:153/255.0 blue:225/255.0 alpha:1.0];
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 32)];
    titleLabel.text = @"时光旅行";
    titleLabel.center = CGPointMake(screenWidth()/2, 42);    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font  = [UIFont systemFontOfSize:25];
    titleLabel.textColor = [UIColor whiteColor];
    [view addSubview:titleLabel];
    
    
    UIButton *leftButton = [self createButtonWithImageName:@"iconfont-more" action:@selector(leftButtonAction)];
    leftButton.frame = CGRectMake(0, 20, 44, 44);
    
    _rightButton = [self createButtonWithImageName:@"iconfontsearch" action:@selector(rightButtonAction:)];
    
    _rightButton.frame = CGRectMake(screenWidth()-44, 20, 44, 44);
    [view addSubview:_rightButton];
    [view addSubview:leftButton];
    [self.view addSubview:view];
    
}
- (void)rightButtonAction:(UIButton *)button {
    
    if (_searchView == nil) {
        _searchView = [[SearchView alloc] init];
        _searchView.frame = CGRectMake(0, 64, screenWidth(), 0);
        _searchView.delegate = self;
        _searchView.dataModel = _homeModel.data;
        [self.view addSubview:_searchView];
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(screenWidth() - 44, 20, 0, 44.0)];
        [_searchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"composehuatiinput"] forState:UIControlStateNormal];
        _searchBar.placeholder = @"故事,游记,目的地,搜搜看";
        _searchBar.delegate = self;
        [_searchBar setBarTintColor:[UIColor colorWithRed:21/255.0 green:153/255.0 blue:225/255.0 alpha:1.0]];
        _searchBar.hidden = YES;
        [self.view addSubview:_searchBar];
        
    }
    if ([_searchBar isHidden]) {
        [button setImage:nil forState:UIControlStateNormal];
        [button setTitle:@"取消" forState:UIControlStateNormal];
        _searchBar.hidden = NO;
        _searchView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _searchView.frame = CGRectMake(0, 64, screenWidth(), screenHeight() - 64);
            _searchView.alpha = 0.95;
            _searchBar.frame = CGRectMake(0, 20, screenWidth() - 44, 44.0);
        }];
    } else {
        
        [_searchBar resignFirstResponder];
        _searchBar.hidden = YES;
        _searchBar.text = @"";
        [button setTitle:nil forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 animations:^{
            [button setImage:[UIImage imageNamed:@"iconfontsearch"] forState:UIControlStateNormal];
            _searchView.frame = CGRectMake(0, 64, screenWidth(), 0);
            _searchView.alpha = 0.0;
            _searchBar.frame = CGRectMake(screenWidth() - 44, 20, 0, 44.0);
        }];
        _searchView.hidden = YES;
    }
}

- (void)leftButtonAction {
    [self.mm_drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}
- (UIButton *)createButtonWithImageName:(NSString *)imageName action:(SEL)selector {
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}
#pragma mark dataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return 1;
    }
    NSLog(@"_++++=%ld",_travelNotesArray.count);

    return _travelNotesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //banner
    if (indexPath.section == 0) {
        static NSString *fier = @"fier";
        BannerViewCell *cell = [[BannerViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:fier];
        cell.model = _elementModel;
  //      cell.delegate = self;
        return cell;
    }
    
    //story
    if (indexPath.section == 1) {
        static NSString *fier = @"cellId";
        BOOL nibsRegistered = NO;
        if (!nibsRegistered) {
            UINib *nib = [UINib nibWithNibName:@"StoryViewCell" bundle:nil];
            [tableView  registerNib:nib forCellReuseIdentifier:fier];
            nibsRegistered = YES;
        }
        StoryViewCell *cell = (StoryViewCell *)[tableView dequeueReusableCellWithIdentifier:fier];
        //避免指针的循环引用
        __weak typeof(self) weakSelf = self;
        
        if (_storyModelAray.count == 4) {
            cell.storyModels = _storyModelAray;
        }
        cell.storyItemSelectBlock = ^(HotSpotListModel *model){
            StoryDetailViewController *storyDetailViewController = [[StoryDetailViewController alloc] init];
            storyDetailViewController.model = model;
            [weakSelf.navigationController pushViewController:storyDetailViewController animated:YES];
        };
        cell.moreActionBlock = ^{
            MoreStoryViewController *moreStoryViewController = [[MoreStoryViewController alloc] init];
            [weakSelf.navigationController pushViewController:moreStoryViewController animated:YES];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return  cell;
    }
    //travel notes
    static NSString *fier = @"travelCellId";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"TeavelNotesViewCell" bundle:nil];
        [tableView  registerNib:nib forCellReuseIdentifier:fier];
        nibsRegistered = YES;
    }
    TeavelNotesViewCell *cell = (TeavelNotesViewCell *)[tableView dequeueReusableCellWithIdentifier:fier];
    NSLog(@"%@",[_travelNotesArray description]);
    cell.model = _travelNotesArray[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}
#pragma mark tableDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return screenWidth()/2;
    }
    if (indexPath.section == 1) {
        return 380;
    }
    return 180;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        UIView *view = [[UIView alloc] init];
        UILabel *colorLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 4, 20)];
        colorLabel.backgroundColor = [UIColor colorWithRed:0.0 green:121/255.0 blue:1.0 alpha:1.0];
        [view addSubview:colorLabel];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(15, 0, 100, 20);
        label.textColor = [UIColor darkTextColor];
        label.text = @"精彩游记";
        label.font = [UIFont systemFontOfSize:17.0];
        [view addSubview:label];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 2) {
        return 30;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        TravelNoteDetailController *tndc = [[TravelNoteDetailController alloc] init];
       // ElementDataModel *model = _travelNotesArray[indexPath.row];
        tndc.model = _travelNotesArray[indexPath.row];
        [self.navigationController pushViewController:tndc animated:YES];
    }
    
}


#pragma mark bannerdelegate
//- (void)TapImageAction:(CGFloat)offset {
//    BannerdescViewController *dvc = [BannerdescViewController new];
//    ElementDataModel  *model = [ElementDataModel new];
//    if (offset == 0.0) {
//        
//        model = _elementModel.data[0];
//        
//    }else if (offset == 375.0){
//        
//        model = _elementModel.data[1];
//        
//    }else if (offset == 750.0){
//        
//        model = _elementModel.data[2];
//        
//    }else if (offset == 1125.0){
//        
//        model = _elementModel.data[3];
//        
//    }
//    dvc.bannerUrl = model.html_url;
//    [self.navigationController pushViewController:dvc animated:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
#pragma mark - UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    _searchView.frame = CGRectMake(0, 64, screenWidth(), 0);
    _searchBar.frame = CGRectMake(screenWidth() - 44, 20, 0, 44.0);
    _searchView.hidden = YES;
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    //在地址遇到中文或特殊字符的时候,需要转码,服务端会有对应的解码
    searchViewController.keyString = URLEncodedString(searchBar.text);
    [self.navigationController pushViewController:searchViewController animated:YES];
    _searchBar.text = @"";
    [_rightButton setTitle:nil forState:UIControlStateNormal];
    [_rightButton setImage:[UIImage imageNamed:@"iconfontsearch"] forState:UIControlStateNormal];
    _searchBar.hidden = YES;
}
#pragma mark SearchViewDelegate
- (void)hiddenSearchView {
    [_searchBar resignFirstResponder];
    _searchView.hidden = YES;
    _searchBar.text = @"";
    
    [_rightButton setImage:[UIImage imageNamed:@"iconfontsearch"] forState:UIControlStateNormal];
    [_rightButton setTitle:nil forState:UIControlStateNormal];
    
    [UIView animateWithDuration:0.3 animations:^{
        _searchView.frame = CGRectMake(0, 64, screenWidth(), 0);
        _searchBar.frame = CGRectMake(screenWidth() - 44, 20, 0, 44.0);
    }];
    _searchBar.hidden = YES;
}
- (void)searchButtonAction:(NSInteger)buttonTag {
    
    _searchView.frame = CGRectMake(0, 64, screenWidth(), 0);
    _searchBar.frame = CGRectMake(screenWidth() - 44, 20, 0, 44.0);
    _searchView.hidden = YES;
    _searchBar.hidden = YES;
    [_rightButton setImage:[UIImage imageNamed:@"iconfontsearch"] forState:UIControlStateNormal];
    [_rightButton setTitle:nil forState:UIControlStateNormal];
    HomeDataModel *dataModel = _homeModel.data;
    SearchModel *searchModel1 = [dataModel.search_data firstObject];
    SearchModel *searchModel2 = [dataModel.search_data lastObject];
    SearchElementModel *elementModel = nil;
    [_searchBar resignFirstResponder];
    if (buttonTag < 6000) {
        elementModel = searchModel1.elements[buttonTag - 5000];
    } else {
        elementModel = searchModel2.elements[buttonTag - 6000];
    }
    PlaceModel *place = [[PlaceModel alloc] init];
    place.type = elementModel.type;
    place.pid = elementModel.sid;
    PlaceDetailController *placeVc= [[PlaceDetailController alloc] init];
    placeVc.model = place;
    [self.navigationController pushViewController:placeVc animated:YES];
    _searchBar.text = @"";
    
}
@end
