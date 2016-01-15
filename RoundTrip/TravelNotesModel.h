//
//  TravelNotesModel.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface PhothInfoModel : JSONModel
@property (nonatomic, copy) NSString *h;
@property (nonatomic, copy) NSString *w;
@end

@interface PoiModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*spot_region;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString <Optional>*descriptionp;
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString <Optional>*name_en;


@end
@protocol WaypointsModel

@end
@interface WaypointsModel : JSONModel
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *photo_1600;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *photo_webtrip;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *photo_weblive;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *photo_s;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *photo_w640;
@property (nonatomic, copy) NSString *local_time;
@property (nonatomic, strong) PoiModel <Optional>*poi;
@property (nonatomic, strong) PhothInfoModel<Optional> *photo_info;

@end

@protocol DaysModel
@end
@interface DaysModel : JSONModel
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *day;
@property (nonatomic, strong) NSArray <WaypointsModel>*waypoints;
@end

@interface NoteAuthorModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *avatar_m;
@end

@protocol CoveredCountriesModel
@end

@interface CoveredCountriesModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *icon;
@end

@interface TravelNotesModel : JSONModel
@property (nonatomic, copy) NSString *first_timezone;
@property (nonatomic, copy) NSString *trackpoints_thumbnail_image;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover_image;
@property (nonatomic, strong) NSArray <CoveredCountriesModel>*covered_countries;
@property (nonatomic, copy) NSString *first_day;
@property (nonatomic, copy) NSString *last_day;
@property (nonatomic, strong) NSArray *cities;
@property (nonatomic, strong) NoteAuthorModel *user;
@property (nonatomic, strong) NSArray <DaysModel>*days;

@end
