//
//  PlaceDetailController.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceDetailController.h"
#import "UIView+Common.h"
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "AllUrl.h"
#import "SearchMoreModel.h"
#import "PlaceDetailViewCell.h"
#import "PlaceDataModel.h"
#import "BannerdescViewController.h"
#import "HotPlaceCell.h"
#import "PlaceNoteViewController.h"
#import "PictureViewController.h"
#import "PlaceInfoController.h"

@interface PlaceDetailController ()<UITableViewDataSource, UITableViewDelegate,PlaceTypeButtonDelegate,HotPlaceTapDelegate>{
    NSMutableArray *_toolsArray;
    NSMutableArray *_hotPlaceArray;
    UIView *_view;
}

@property (nonatomic, retain) UIImageView *imgProfile;
@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) CGFloat ImageWidt;
@property (nonatomic, assign) CGFloat ImageHeight;
@property (nonatomic, copy) NSString *keyUrl;
@property (nonatomic, strong) AllPlaceModel *placeModel;
@end

@implementation PlaceDetailController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    _toolsArray = [NSMutableArray new];
    _hotPlaceArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1.0];
    [self createTableViews];
    [self loadNetData];
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
- (void)createTableViews {
    _ImageWidt = screenWidth();
    _ImageHeight = screenWidth();
    
    self.imgProfile = [[UIImageView alloc] init];
    self.imgProfile.frame = CGRectMake(0, 0, _ImageWidt, _ImageHeight);
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style: UITableViewStyleGrouped];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.imgProfile];
    [self.view addSubview:self.tableView];
    
}
- (void)updateImg {
    CGFloat yOffset   = _tableView.contentOffset.y;
 
    if (yOffset < 0) {
        
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
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        NSInteger i=0;
        for (PlaceModel *model in _toolsArray) {
            if (model.url.length > 0 ) {
                i++;
            }
        }
        CGFloat height = 0;
        if(i <= 4){
            height = (screenWidth() - 5*10)/4 +20;
        } else {
            
            height = (screenWidth() - 5*10)/2 +30;
        }
        return  height;
    }
    else{
        CGFloat width = (screenWidth() - 3 * 10)/2;
        if (_hotPlaceArray.count > 0) {
            if (_hotPlaceArray.count%2==0) {
                return (_hotPlaceArray.count/2)*(10 + width)+10;
            }else {
                
                return(_hotPlaceArray.count/2+1)*(10 + width)+10;;
            }
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellReuseIdentifier   = @"Identifier";
    
    if(indexPath.section == 0){
       
            PlaceDetailViewCell  *myCell  = [tableView dequeueReusableCellWithIdentifier:cellReuseIdentifier];
            if (!myCell) {
                myCell = [[PlaceDetailViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellReuseIdentifier];
            }
            myCell.selectionStyle = UITableViewCellSelectionStyleNone;
            myCell.toolsArray = _toolsArray;
            myCell.delegate = self;
            return myCell;
    } else {
        
        HotPlaceCell *placeCell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
        if (!placeCell) {
            placeCell = [[HotPlaceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellId"];
        }
        placeCell.delegate = self;
        placeCell.selectionStyle = UITableViewCellSelectionStyleNone;
        placeCell.placeArray = _hotPlaceArray;
        return placeCell;
        
    }
    
}


#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _view.alpha = 0;
    [self.navigationController setNavigationBarHidden:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return screenWidth();
    }
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
     UIView *view = [[UIView alloc] init];
    
    if (section == 0) {
        view.frame = CGRectMake(0, 0, screenWidth(), screenWidth());
        CGFloat padding = 10.0;
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
    if (section == 1 && _hotPlaceArray.count > 0) {
        view.backgroundColor = [UIColor whiteColor];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 0, screenWidth(), 40);
        label.text = @"热门地点";
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:25];
        label.textColor = [UIColor grayColor];
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapMoreAction)];
        [label addGestureRecognizer:tapGestureRecognizer];
        [view addSubview:label];
    }
    return view;
}
- (void)tapMoreAction {

    NSLog(@"%s",__func__);

}

- (void)tapAction {
    PictureViewController *picController = [[PictureViewController alloc] init];
    NSString *typeString = [NSString stringWithFormat:@"/%@/%@/",_placeModel.type,_placeModel.eid];
    picController.typeString = typeString;
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self.navigationController pushViewController:picController animated:YES];
}
- (NSString *)switchString:(NSString *)string {
    NSInteger count = [string integerValue];
    NSString *countString = [NSString new];
    if (count >= 10000) {
        countString = [NSString stringWithFormat:@"%.1ldk",count/1000];
    } else {
        countString = [NSString stringWithFormat:@"%ld",(long)count];
    }
    return countString;
}
- (void)loadNetData {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *urlString = [NSString stringWithFormat:@"/%@/%@/",_model.type,_model.pid];
    NSString *url = [NSString stringWithFormat:ALLPLACESURL,urlString];
    [manager.requestSerializer setValue:@"BreadTrip/6.2.0/zh (iPhone8,1; iPhone OS9.2; zh-Hans-CN zh_CN)" forHTTPHeaderField:@"User-Agent"];
    [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        _placeModel = [[AllPlaceModel alloc] initWithData:responseObject error:&error];
        [_toolsArray  addObjectsFromArray:_placeModel.tools];
        [_hotPlaceArray addObjectsFromArray:_placeModel.hottest_sites];
        HottestPlacesModel *hotModel = [_placeModel.hottest_places firstObject];
        [_imgProfile sd_setImageWithURL:[NSURL URLWithString:hotModel.photo] placeholderImage:nil];
        NSString *typeString = [NSString stringWithFormat:@"/%@/%@/trips/?start=",_placeModel.type,_placeModel.eid];
        _keyUrl = [NSString stringWithFormat:ALLPLACESURL,typeString];
        [_tableView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error description]);
    }];
}
#pragma mark PlaceTypeButtonDelegate
- (void)placeTypeButtonAction:(NSInteger)tag {
    
    if (tag == 2) {
       
    } else if(tag == 3){
        PlaceNoteViewController *tripsViewController = [[PlaceNoteViewController alloc] init];
        tripsViewController.keyString = _keyUrl;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController pushViewController:tripsViewController animated:YES];
    }else {
        for (ToolsModel *model in _toolsArray) {
            if ([model.type integerValue] == tag) {
                BannerdescViewController *controller = [[BannerdescViewController alloc]init];
                controller.bannerUrl = model.url;
                [self.navigationController setNavigationBarHidden:NO animated:YES];
                [self.navigationController pushViewController:controller animated:YES];
            }
        }
    }
}
#pragma mark Hotplacedelegate
- (void)tapPictureAction:(NSInteger)tag {
   
    HottestSitesModel *model = _hotPlaceArray[tag];
    NSString *typeString = [NSString stringWithFormat:@"/%@/%@/",model.type,model.hid];
    if ([model.type isEqualToString:@"5"]) {
        PlaceInfoController *pic = [[PlaceInfoController alloc] init];
        pic.typeString = typeString;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController pushViewController:pic animated:YES];
    } else if ([model.type isEqualToString:@"3"]||[model.type isEqualToString:@"1"]){
        PlaceDetailController *placeVc = [[PlaceDetailController alloc] init];
        PlaceModel *placeModel = [[PlaceModel alloc] init];
        placeModel.type = model.type;
        placeModel.pid = model.hid;
        placeVc.model = placeModel;
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        [self.navigationController pushViewController:placeVc animated:YES];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
