//
//  ListViewController.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//
#import "BaseViewController.h"
@class AFHTTPSessionManager;
@interface ListViewController : BaseViewController {
    NSMutableArray *_dataSourceArray;
    UITableView *_tableView;
    AFHTTPSessionManager *_manager;
}

@property (nonatomic, copy) NSString *requestURL;
- (void)loadNetData:(BOOL)isMore;
- (void)initData;
- (void) createRefresh;
- (void)createDataSource;
@end
