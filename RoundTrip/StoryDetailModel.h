//
//  StoryDetailModel.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserDetailModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *user_desc;
@property (nonatomic, copy) NSString *avatar_m;
@property (nonatomic, copy) NSString *location_name;
@end

@interface TripModel : JSONModel
@property (nonatomic, copy) NSString *day_count;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) UserDetailModel *user;
@end
@protocol DetailListModel

@end

@interface DetailListModel : JSONModel

@property (nonatomic, copy) NSString *photo_width;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *photo_w640;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *photo_date_created;
@property (nonatomic, copy) NSString *photo_height;
@property (nonatomic, copy) NSString <Optional>*date_tour;
@end

@interface SpotModel : JSONModel
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *trip_id;
@property (nonatomic, copy) NSString *cover_image_w640;
@property (nonatomic, copy) NSString *view_count;
@property (nonatomic, copy) NSString *cover_image_height;
@property (nonatomic, strong) NSArray <DetailListModel>* detail_list;

@end

@interface StoryDataModel : JSONModel
@property (nonatomic, strong) SpotModel *spot;
@property (nonatomic, strong) TripModel *trip;
@end
@interface StoryDetailModel : JSONModel
@property (nonatomic, strong) StoryDataModel *data;
@end
