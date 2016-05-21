//
//  ListStoryModel.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>


@protocol UserNameModel

@end
@interface UserNameModel : JSONModel
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *avatar_m;
@end
@protocol HotSpotListModel
@end
@interface HotSpotListModel : JSONModel
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *index_cover;
@property (copy, nonatomic) NSString *index_title;
@property (copy, nonatomic) NSString *view_count;
@property (copy, nonatomic) NSString *spot_id;
@property (copy, nonatomic) NSString *share_url;
@property (nonatomic, strong) UserNameModel<Optional> *user;

@end

@interface ListDataModel : JSONModel
@property (strong, nonatomic) NSArray <HotSpotListModel>*hot_spot_list;
@end
@interface ListStoryModel : JSONModel
@property (strong, nonatomic) ListDataModel *data;
@end
