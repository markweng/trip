//
//  PlaceInfoController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceInfoController.h"
#import <AFNetworking/AFNetworking.h>
#import "AllUrl.h"
#import "UIView+Common.h"
#import "TheLastPlaceModel.h"
#import <UIImageView+WebCache.h>
#import "TextTableCell.h"
#import "NSString+Commom.h"
#import "InfoTableViewCell.h"
#import "PictureViewController.h"
@interface PlaceInfoController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *_dataArray;
    UIView *_view;
    
    
}
@property (nonatomic, retain) UIImageView *imgProfile;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) CGFloat ImageWidt;
@property (nonatomic, assign) CGFloat ImageHeight;
@property (nonatomic, copy) NSString *keyUrl;
@property (nonatomic, strong) TheLastPlaceModel *placeModel;

@end

@implementation PlaceInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    self.view.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    [self loadNetData];
    [self createTableViews];
    [self customNavigationBar];
    
}

- (void)customNavigationBar {
   
    _view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth(), 64)];
    _view.backgroundColor = [UIColor colorWithRed:21/255.0 green:153/255.0 blue:225/255.0 alpha:1.0];
     UIButton *button = [[UIButton alloc] init];
    
     button.frame = CGRectMake(0, 20, 44, 44);
    [button setImage:[UIImage imageNamed:@"leftIcon"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_view];
    [self.view addSubview:button];
   
    
}
- (void)backAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)loadNetData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url = [NSString stringWithFormat:ALLPLACESURL,_typeString];
    [manager.requestSerializer setValue:@"BreadTrip/6.2.0/zh (iPhone8,1; iPhone OS9.2; zh-Hans-CN zh_CN)" forHTTPHeaderField:@"User-Agent"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error=nil;
        _placeModel = [[TheLastPlaceModel alloc] initWithData:responseObject error:&error];
        if (!error) {
            HotTestPlaseModel *hotModel = [_placeModel.hottest_places firstObject];
            [_imgProfile sd_setImageWithURL:[NSURL URLWithString:hotModel.photo] placeholderImage:nil];
            NSArray *title = @[@"概况",@"地址",@"交通",@"开放时间"];
            NSArray *content = @[_placeModel.mydescription,_placeModel.address,_placeModel.arrival_type,_placeModel.opening_time];
            for (NSInteger i=0; i<title.count; i++) {
                NSMutableArray *array = [[NSMutableArray alloc] init];
                [array addObject:title[i]];
                [array addObject:content[i]];
                if ([content[i] length]>0) {
                    [_dataArray addObject:array];
                }
            }
            [_tableView reloadData];
        } else {
            UILabel *label = [[UILabel alloc] init];
            label.text = @"该景点暂时没有数据，等待旅友们的探索哦！";
            label.frame = CGRectMake(0, 0, screenWidth(), 30);
            label.center = CGPointMake(screenWidth()/2, screenHeight()/2);
            label.textColor = [UIColor lightGrayColor];
            label.textAlignment = NSTextAlignmentJustified;
            label.numberOfLines = 0;
            [self.view addSubview:label];
            _view.alpha = 1.0;
            _tableView.hidden = YES;
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error description]);
    }];
}



- (void)createTableViews {
    _ImageWidt = screenWidth();
    _ImageHeight = screenWidth();
    
    self.imgProfile = [[UIImageView alloc] init];
    self.imgProfile.frame = CGRectMake(0, 0, _ImageWidt, _ImageHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:self.imgProfile];
    [self.view addSubview:self.tableView];
    
}
- (void)updateImg {
    CGFloat yOffset   = _tableView.contentOffset.y;
    if (yOffset <= 0) {
        
        CGFloat factor = ((ABS(yOffset)+_ImageHeight)*_ImageWidt)/_ImageHeight;
        CGRect f = CGRectMake(-(factor-_ImageWidt)/2, 0, factor, _ImageHeight+ABS(yOffset));
        self.imgProfile.frame = f;
        _view.alpha = 0;
        
        
    } else if (yOffset >0 ){
        CGRect f = self.imgProfile.frame;
        f.origin.y = -yOffset/2;
        self.imgProfile.frame = f;
        _view.alpha = yOffset/(screenWidth()-64);
    }
}


#pragma mark - Table View Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self updateImg];
}

#pragma mark - Table View Datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    return _dataArray.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        NSString *cellReuseIdentifier   = @"Identifier";
        TextTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if (!cell) {
            cell = [[TextTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        cell.textString = _placeModel.recommended_reason;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    } else {
        NSString *cellReuseIdentifier   = @"fier";
        InfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
        if (!cell) {
            cell = [[InfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
        }
        cell.infoArray = _dataArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CGSize size = [_placeModel.recommended_reason sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(screenWidth() - 50, MAXFLOAT)];
        NSLog(@"%f",size.height);
        return size.height + 10;
    } else {
        CGSize size = [_dataArray[indexPath.row][1] sizeWithFont:[UIFont systemFontOfSize:15] maxSize:CGSizeMake(screenWidth() - 20, MAXFLOAT)];
        return size.height + 50;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return screenWidth();
    }
    return 0.01;
}
#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _view.alpha = 0;
    [self.navigationController setNavigationBarHidden:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        CGFloat padding = 10.0;
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(0, 0, screenWidth(), screenWidth());
        view.backgroundColor = [UIColor clearColor];
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.frame = CGRectMake(20, screenWidth() - 20 - 2*padding -25, screenWidth() - 20, 25);
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.text = _placeModel.name;
        nameLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:25];
        nameLabel.textColor = [UIColor whiteColor];
        UILabel *countLabel = [[UILabel alloc] init];
        NSString *string = [NSString stringWithFormat:@"%@人去过|%@人想去",[self switchString:_placeModel.visited_count] ,[self switchString:_placeModel.wish_to_go_count]];
        countLabel.text = string;
        countLabel.frame = CGRectMake(20, getMaxY(nameLabel) + padding, screenWidth()-100, 20);
        countLabel.font = [UIFont systemFontOfSize:15];
        countLabel.textColor = [UIColor whiteColor];
        countLabel.backgroundColor = [UIColor clearColor];
        UIView *picView =[[UIView alloc] init];
        picView.frame = CGRectMake(screenWidth()-100, getMinY(countLabel), 90, 20);
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pictureIcon"]];
        imageView.userInteractionEnabled = YES;
        imageView.frame = CGRectMake(0, 0, 20, 20);
        UILabel *picCountLabel = [[UILabel alloc] init];
        picCountLabel.frame = CGRectMake(getMaxX(imageView)+5, getMinY(imageView), 65, 20);
        picCountLabel.textColor = [UIColor whiteColor];
        picCountLabel.font = [UIFont systemFontOfSize:15];
        picCountLabel.text = [NSString stringWithFormat:@"%@ 张",[self switchString:_placeModel.photo_count]];
        [picView addSubview:picCountLabel];
        [picView addSubview:imageView];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction)];
        [picView addGestureRecognizer:tapGestureRecognizer];
        [view addSubview:picView];
        [view addSubview:countLabel];
        [view addSubview:nameLabel];
        return view;
    }
    
    return nil;
}
- (void)tapAction {
    NSString *string = [NSString stringWithFormat:@"/%@/%@/",_placeModel.type,_placeModel.eid];
    PictureViewController *picv = [[PictureViewController alloc] init];
    picv.typeString = string;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:picv animated:YES];
    
}
- (NSString *)switchString:(NSString *)string {
    NSInteger count = [string integerValue];
    NSString *countString = [NSString new];
    if (count >= 10000) {
        countString = [NSString stringWithFormat:@"%.1ld k",count/1000];
    } else {
        countString = [NSString stringWithFormat:@"%ld",(long)count];
    }
    return countString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
