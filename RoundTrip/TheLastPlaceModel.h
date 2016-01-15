//
//  TheLastPlaceModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol HotTestPlaseModel


@end
@interface HotTestPlaseModel : JSONModel
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *content_type;
@end

@interface TheLastPlaceModel : JSONModel
@property (nonatomic, copy) NSString *visited_count;
@property (nonatomic, copy) NSString *eid;
@property (nonatomic, copy) NSString *recommended_reason;
@property (nonatomic, copy) NSString <Optional>*time_consuming;
@property (nonatomic, copy) NSString *opening_time;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *photo_count;
@property (nonatomic, copy) NSString *mydescription;
@property (nonatomic, copy) NSString *arrival_type;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *name_en;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *wish_to_go_count;
@property (nonatomic, strong) NSArray <HotTestPlaseModel>*hottest_places;

@end
