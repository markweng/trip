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
  //  UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(mainScreenW/5*4/2-30, 80, 60, 60)];
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
       // _headerView.layer.cornerRadius = 30;

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

}
- (void)loginOut {

    [_headerBtn setImage:[UIImage imageNamed:@"user"] forState:UIControlStateNormal];
    _nameLabel.text = @"未登陆";


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
    NSArray *array = @[@"我的收藏",@"清理缓存",@"免责声明",@"关于我们",@"退出登录",@"关闭"];
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
    //  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
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
//            UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"免责声明" message:@"  本App作为一个网络平台，不存在商业目的，所有内容均来自互联网，以通过交流与分享，达到传递与分享的目的，因此本App所链接内容仅供网友了解与借鉴，无意侵害原作者版权；未完整注明作者或出处的链接，并非不尊重作者或者链接来源。" preferredStyle:UIAlertControllerStyleAlert];
//            
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
//            [alerController addAction:cancelAction];
//            [self presentViewController:alerController animated:YES completion:nil];
            DeclareViewController  *dlVC = [[DeclareViewController alloc] init];
            [self presentViewController:dlVC animated:YES completion:^{
                
            }];
            
            
        }
            break;
        case 3:
        {
            UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"关于我们" message:@" D.W是一支以交互体验为核心的产品团队，交互设计，动态视觉设计，GUI设计，产品设计是我们的擅长点，多样的客户渠道和深入的行业人脉是我们的资源链，巧妙的跨界整合伴随着我们一直成长，D.W坚信专注于设计品质和交互体验的提升，将会为用户创造出更好的产品服务。" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"返回" style:UIAlertActionStyleCancel handler:nil];
            [alerController addAction:cancelAction];
            [self presentViewController:alerController animated:YES completion:nil];
            
        }
            break;
        case 4:
        {
            [BmobUser logout];
            [self loginOut];
        }
            break;
            case 5:
        {
         [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        }
        default:
            break;
    }
}
#pragma 清理缓存图片

- (void)clearTmpPics
{
    //[[SDImageCache sharedImageCache] clearDisk];
    
    //    [[SDImageCache sharedImageCache] clearMemory];//可有可无
    
  //  DLog(@"clear disk");
    
   // float tmpSize = [[SDImageCache sharedImageCache] getSize];
    
  //  NSString *clearCacheName = tmpSize >= 1 ? [NSString stringWithFormat:@"清理缓存(%.2fM)",tmpSize] : [NSString stringWithFormat:@"清理缓存(%.2fK)",tmpSize * 1024];
    
   // [configDataArray replaceObjectAtIndex:2 withObject:clearCacheName];
    
    //[configTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}
- (void)dealloc {

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
