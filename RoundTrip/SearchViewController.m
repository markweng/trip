//
//  SearchViewController.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/31.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "SearchViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "AllUrl.h"
#import "SearchMoreModel.h"
#import "UIView+Common.h"
#import "SearchTravelNotesCell.h"
#import "SearchMoreTripsControllerViewController.h"
#import "TravelNoteDetailController.h"
#import "PlaceDetailController.h"
#import "AllUrl.h"
#import "PlaceTripItemModel.h"
#import "PlaceInfoController.h"
@interface SearchViewController ()<UITableViewDataSource,UITableViewDelegate>{
    
    NSMutableArray *_placeArray;
    NSMutableArray *_tripsArray;
    
}

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _placeArray = [[NSMutableArray alloc] init];
    _tripsArray = [[NSMutableArray alloc] init];
    CGRect frame = self.view.bounds;
    frame.origin.y += 64;
    frame.size.height -= 64;
    _tableView.frame = frame;
}
- (void)createRefresh {
    
}
- (void)loadNetData:(BOOL)isMore {
    NSString *urlString = [NSString stringWithFormat:SEARCHURL,_keyString];
    [_manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSError *error = nil;
        SearchMoreModel *searchModel = [[SearchMoreModel alloc] initWithData:responseObject error:&error];
        
        if (searchModel.data.places != nil) {
            for (PlaceModel *model in searchModel.data.places) {
                if ([model.type integerValue] == 1 || [model.type integerValue] == 3|| [model.type integerValue] == 5) {
                    [_placeArray addObject:model];
                }
            }
        }
        if (searchModel.data.trips != nil) {
            [_tripsArray addObjectsFromArray:searchModel.data.trips];
        }
        [_tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",[error description]);
    }];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return _placeArray.count;
    }
    return _tripsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier;
    if (indexPath.section == 0) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        PlaceModel *place = _placeArray[indexPath.row];
        cell.textLabel.text = place.name;
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    
    static NSString *fier = @"fier";
    BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"SearchTravelNotesCell" bundle:nil];
        [tableView  registerNib:nib forCellReuseIdentifier:fier];
        nibsRegistered = YES;
    }
    SearchTravelNotesCell *cell = (SearchTravelNotesCell *)[tableView dequeueReusableCellWithIdentifier:fier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    TripsModel *trip = _tripsArray[indexPath.row];
    cell.model = trip;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    UILabel *label = [[UILabel alloc] init];
    label.textColor = [UIColor grayColor];
    label.frame = CGRectMake(0, 0, screenWidth(), 50);
    label.font = [UIFont fontWithName:@"Arial Rounded MT Bold" size:17];
    label.textAlignment = NSTextAlignmentCenter;
    
    if (section == 0 && _placeArray.count != 0 ) {
        
        label.text = @"相关目的地";
        
        [view addSubview:label];
        return view;
        
    }
    if (section == 1 && _tripsArray.count != 1) {
        UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didSelectHeader)];;
        label.text = @"相关游记，故事 >>";
        [view addSubview:label];
        [view addGestureRecognizer:tapGestureRecognizer];
        return view;
    }
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && _placeArray.count != 0 ) {
        return 50;
    }
    if (indexPath.section == 1 && _tripsArray.count != 1) {
        return 100;
    }
    return 0;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 && _placeArray.count != 0 ) {
        return 50;
    }
    if (section == 1 && _tripsArray.count != 1) {
        return 50;
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        
        PlaceModel *place = _placeArray[indexPath.row];
        
        if([place.type integerValue] == 1 || [place.type integerValue] == 3 ) {
            
            PlaceDetailController *placeDetialController = [[PlaceDetailController alloc] init];
            placeDetialController.model = place;
            [self.navigationController pushViewController:placeDetialController animated:YES];
            return;
        }
        if ([place.type integerValue] == 5) {
            PlaceInfoController *pic = [[PlaceInfoController alloc] init];
            pic.typeString = [NSString stringWithFormat:@"/%@/%@/",place.type,place.pid];
            [self.navigationController pushViewController:pic animated:YES];
            return;
        }
        
    }
    if (indexPath.section == 1) {
        TravelNoteDetailController *noteDetailController = [[TravelNoteDetailController alloc] init];
        TripsModel *trip = _tripsArray[indexPath.row];
        ItemModel *model = [[ItemModel alloc] init];
        model.cover_image =  trip.cover_image_default;
        model.eid = trip.tid;
        model.name = trip.name;
        
        
        noteDetailController.model = model;
        [self.navigationController pushViewController:noteDetailController animated:YES];
    }
}

- (void)didSelectHeader {
    
    SearchMoreTripsControllerViewController *moreTripsController = [[SearchMoreTripsControllerViewController alloc] init];
    NSString *urlString = [NSString stringWithFormat:MORETAIPSURL,_keyString];
    moreTripsController.keyString = urlString;
    [self.navigationController pushViewController:moreTripsController animated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
