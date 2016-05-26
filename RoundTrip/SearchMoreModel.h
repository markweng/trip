//
//  SearchMoreModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "HomeDataModel.h"

@protocol TripsModel


@end
@interface TripsModel : JSONModel
@property (nonatomic, copy) NSString *tid;
@property (nonatomic, copy) NSString *cover_image_default;
@property (nonatomic, copy) NSString *liked_count;
@property (nonatomic, copy) NSString *day_count;
@property (nonatomic, copy) NSString *view_count;
@property (nonatomic, copy) NSString *waypoints;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString <Optional>*share_url;

@end
@interface CountryModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *cid;
@property (nonatomic, strong)  LocationModel <Optional> *location;

@end
@protocol PlaceModel
@end

@interface PlaceModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pid;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString <Optional>*cover;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) CountryModel <Optional>*country;
@end

@interface SearchDataModel : JSONModel
@property (nonatomic, strong)NSArray <PlaceModel,Optional> *places;
@property (nonatomic, strong)NSArray <TripsModel,Optional>*trips;
@end


@interface SearchMoreModel : JSONModel
@property (nonatomic, strong) SearchDataModel *data;
@end
