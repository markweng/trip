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

@interface LeftViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    UITableView *_tableView;
    NSMutableArray *_dataArray;
    
}

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:128/255.0 green:184/255.0 blue:182/255.0 alpha:1.0];
    [self createHeaderView];
    [self createTableView];
    [self createDataSource];
}

- (void)createHeaderView {
    
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenWidth()/3, screenWidth()/3)];
    headerView.image = [UIImage imageNamed:@"headericon"];
    [self.view addSubview:headerView];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] init];
    _tableView.frame = CGRectMake(0, screenWidth()/3, 2 * screenWidth()/3,screenHeight()-screenWidth()/3);
    _tableView.alpha = 0.8;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
}

- (void)createDataSource {
    _dataArray = [[NSMutableArray alloc] init];
    NSArray *array = @[@"我的收藏",@"清理缓存",@"免责声明",@"关于我们",@"关闭"];
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
    cell.textLabel.text = _dataArray[indexPath.row];
    return cell;
}

#pragma mark tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _tableView.frame.size.height/_dataArray.count;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //  AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
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
            UIAlertController *alerController = [UIAlertController alertControllerWithTitle:@"免责声明" message:@"  本App作为一个网络平台，不存在商业目的，所有内容均来自互联网，以通过交流与分享，达到传递与分享的目的，因此本App所链接内容仅供网友了解与借鉴，无意侵害原作者版权；未完整注明作者或出处的链接，并非不尊重作者或者链接来源。" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
            [alerController addAction:cancelAction];
            [self presentViewController:alerController animated:YES completion:nil];
            
            
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
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
            
        }
            break;
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



@end