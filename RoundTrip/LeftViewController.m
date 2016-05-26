//
//  LeftViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/23.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "LeftViewController.h"
#import "UIView+Common.h"
#import <UIImageView+WebCache.h>

#import "AppDelegate.h"
#import "HomeViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <MMDrawerController/MMDrawerController.h>
#import "FavoriteViewController.h"
#import "MyCache.h"
#import "LoginViewController.h"
#import "AllUrl.h"
#import <BmobSDK/Bmob.h>
#import "LoginModel.h"
#import "UserInfoTableViewController.h"
#import "DeclareViewController.h"
#import "AboutUsViewController.h"
#import "FeedBackViewController.h"

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    UIButton *_headerBtn;
    UILabel *_nameLabel;
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:26/255.0 green:31/255.0 blue:36/255.0 alpha:1.0];
    [self createHeaderView];
    [self createTableView];
    [self createDataSource];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess) name:@"LOGINSUCCESS" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginOut) name:@"LOGINOUT" object:nil];
}

- (void)createHeaderView {
  
    _headerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _headerBtn.frame = CGRectMake(20, 80, 60, 60);
    
    [self.view addSubview:_headerBtn];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(getMaxX(_headerBtn) + 10, getMinY(_headerBtn) + 15, 100, 30);
    _nameLabel.textColor = [UIColor lightTextColor];
   
    [self.view addSubview:_nameLabel];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
    [_headerBtn addTarget:self action:@selector(tapAction) forControlEvents:UIControlEventTouchUpInside];
    [_headerBtn addGestureRecognizer:tapGestureRecognizer];

    BmobUser *bUser = [BmobUser getCurrentUser];
    NSLog(@"%@",[bUser description]);
    if (bUser) {
        BmobFile *file = [bUser objectForKey:@"usericon"];
        [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:file.url] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
            
        } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
            [_headerBtn setImage:image forState:UIControlStateNormal];
        }];
        
        _nameLabel.text = [bUser objectForKey:@"nickname"];

    } else {
        [_headerBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
        _nameLabel.text = @"未登陆";
        
    }

}
- (void)loginSuccess {
    
    BmobUser *bUser = [BmobUser getCurrentUser];

    BmobFile *file = [bUser objectForKey:@"usericon"];
    [[SDWebImageManager sharedManager] downloadImageWithURL:[NSURL URLWithString:file.url] options:SDWebImageRefreshCached progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
        [_headerBtn setImage:image forState:UIControlStateNormal];
        _headerBtn.layer.cornerRadius = 30;

    }];

    _nameLabel.text = [bUser objectForKey:@"nickname"];
    NSArray *array = @[@"我的收藏",@"清理缓存",@"免责声明",@"意见反馈",@"关于我们",@"退出登录"];
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:array];
    [_tableView reloadData];

}
- (void)loginOut {

    [_headerBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    _nameLabel.text = @"未登陆";
    NSArray *array = @[@"我的收藏",@"清理缓存",@"免责声明",@"意见反馈",@"关于我们"];
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:array];
    [_tableView reloadData];

}
- (void)tapAction {
    
    BmobUser *bUser = [BmobUser getCurrentUser];

    if (bUser) {
        
       
        UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UserInfoTableViewController *leftController = [mainStoryboard instantiateViewControllerWithIdentifier:@"UserInfoTableViewController"];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:leftController];
       
        [self presentViewController:navController animated:YES completion:^{
            
        }];
        
    } else {
        
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        UINavigationController *NVC = [[UINavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:NVC animated:YES completion:^{
            
        }];
    }
}
- (void)createTableView {
    
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, 160, screenWidth()/5*4,screenHeight()-20);
    _tableView.backgroundColor = [UIColor colorWithRed:26/255.0 green:31/255.0 blue:36/255.0 alpha:1.0];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}

- (void)createDataSource {
    
    _dataArray = [[NSMutableArray alloc] init];
     BmobUser *bUser = [BmobUser getCurrentUser];
    NSArray *array = nil;
    if (bUser) {
      array = @[@"我的收藏",@"清理缓存",@"免责声明",@"意见反馈",@"关于我们",@"退出登录"];
    } else {
    
      array = @[@"我的收藏",@"清理缓存",@"免责声明",@"意见反馈",@"关于我们"];
    }
    
    [_dataArray addObjectsFromArray:array];
    
}
#pragma mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.backgroundColor = [UIColor colorWithRed:26/255.0 green:31/255.0 blue:36/255.0 alpha:1.0];
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 44;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            
        {
            UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:[[FavoriteViewController alloc] init]];
            [self.mm_drawerController presentViewController:nv animated:YES completion:nil];
        }
            break;
        case 1:
        {
            CGFloat fileCount  = [MyCache fileSize];
            NSString *sizeString = [NSString stringWithFormat:@"%.2fM",fileCount];
            UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"清理缓存" message:sizeString preferredStyle:UIAlertControllerStyleAlert];
    
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"立即清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
                [MyCache resetCache];
                
            }];
            [alerController addAction:cancelAction];
            [alerController addAction:okAction];
            
            [self presentViewController:alerController animated:YES completion:nil];
        }
            break;
        case 2:
        {

            DeclareViewController  *dlVC = [[DeclareViewController alloc] init];
            [self presentViewController:dlVC animated:YES completion:^{
                
            }];
            
            
        }
            break;
        case 3:
        {
            FeedBackViewController *feedBackVC  = [[FeedBackViewController alloc] init];
            [self presentViewController:feedBackVC animated:YES completion:^{
                
                            }];
            
        }
            break;
        case 4:
        {
            
            
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc] init];
            [self presentViewController:aboutUsVC animated:YES completion:^{

            }];

        }
            break;
            case 5:
        {
            [BmobUser logout];
            [self loginOut];

        // [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        }
        default:
            break;
    }
}
#pragma 清理缓存图片

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
