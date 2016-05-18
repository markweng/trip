//
//  FavoriteViewController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/8.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "FavoriteViewController.h"
#import "UIView+Common.h"
#import "DBManager.h"
#import "StroyCell.h"
#import "PlaceTripItemModel.h"
#import "StoryDetailViewController.h"
#import "TravelNoteDetailController.h"
#import "ListStoryModel.h"
@interface FavoriteViewController () <UITableViewDataSource, UITableViewDelegate>{

    UITableView *_tableView;
    NSMutableArray *_storyDataArray;
    NSMutableArray *_tripDataArray;
}

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    [self createDataSource];
    self.titleString = @"我的收藏";

}

- (void)createLabel {
    if (_storyDataArray.count == 0&& _tripDataArray.count == 0) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, screenWidth(), 40);
        label.center = CGPointMake(screenWidth()/2, screenHeight()/2);
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"空空如也，看见喜欢的可以收藏到这里哦～";
        label.textColor = [UIColor lightGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:label];
    }
    return;
}
- (void)createDataSource {
    _storyDataArray = [NSMutableArray new];
    [_storyDataArray addObjectsFromArray:[[DBManager sharedManager] readModelsWithRecordType:@"story"]];
    _tripDataArray = [NSMutableArray new];
    [_tripDataArray addObjectsFromArray:[[DBManager sharedManager] readModelsWithRecordType:@"trip"]];
    [self createLabel];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
    
}
- (void)createTableView {
    CGRect frame = self.view.bounds;
    frame.origin.y +=64;
    frame.size.height -= 64;
    _tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

#pragma  mark datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 2;

}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    if (section == 0) {
        return _storyDataArray.count;
    } else {
        return _tripDataArray.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *fier = @"fier";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"StroyCell" bundle:nil];
        [tableView  registerNib:nib forCellReuseIdentifier:fier];
        nibsRegistered = YES;
    }
    StroyCell *cell = (StroyCell *)[tableView dequeueReusableCellWithIdentifier:fier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        ItemModel *model = [[ItemModel alloc] init];
        model = _storyDataArray[indexPath.row];
        cell.model = model;
    
        cell.block = ^{
            [[DBManager sharedManager] deleteModelForPid:model.eid];
            [_storyDataArray removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        };
        
    } else {
        ItemModel *model = [[ItemModel alloc] init];
        model = _tripDataArray[indexPath.row];
        cell.model = model;
        cell.block = ^{
            [[DBManager sharedManager] deleteModelForTripid:model.eid];
            [_tripDataArray removeObjectAtIndex:indexPath.row];
            [_tableView reloadData];
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0&& _storyDataArray.count == 0) {
        return 0;
    }
    if (section == 1&& _tripDataArray.count == 0) {
        return 0;
    }
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    UILabel *titleLabel = [[UILabel alloc] init];
    if (section == 0) {
        
        titleLabel.text = @"故事";
        view.backgroundColor = [UIColor colorWithRed:72/225.0 green:189/225.0 blue:188/225.0 alpha:0.9];

       
    } else {
        titleLabel.text = @"游记";
        view.backgroundColor = [UIColor colorWithRed:113/255.0 green:186/225.0 blue:32/225.0 alpha:0.9];
    }
    titleLabel.frame = CGRectMake(0, 10, screenWidth(), 20);
     titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    [view addSubview:titleLabel];
    
    return view;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        StoryDetailViewController * storyVc = [[StoryDetailViewController alloc] init];
        HotSpotListModel *model = [[HotSpotListModel alloc] init];
        ItemModel *itemModel = _storyDataArray[indexPath.row];
        model.index_cover = itemModel.cover_image;
        model.index_title = itemModel.name;
        model.spot_id = itemModel.eid;
        storyVc.model = model;
        [self.navigationController pushViewController:storyVc animated:YES];
    } else {
      
        TravelNoteDetailController *travelVc = [[TravelNoteDetailController alloc] init];
        travelVc.model = _tripDataArray[indexPath.row];
      
       [self.navigationController pushViewController:travelVc animated:YES];
    }


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 200;
}
- (void)backAction {
   
  [self dismissViewControllerAnimated:YES completion:^{
      
  }];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
   
}
/*D.W是一支以交互体验为核心的产品团队，交互设计，动态视觉设计，GUI设计，产品设计是我们的擅长点，多样的客户渠道和深入的行业人脉是我们的资源链，巧妙的跨界整合伴随着我们一直成长，D.W坚信专注于设计品质和交互体验的提升，将会为用户创造出更好的产品服务。
    联系我们：
    Mail:hi@dwong.cn
 */

@end
