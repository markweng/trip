//
//  PlaceDataModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "SearchMoreModel.h"

@protocol HottestPlacesModel

@end
@interface HottestPlacesModel : JSONModel

@property (nonatomic, copy) NSString *photo;

@end

@interface Location : JSONModel
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@end

@protocol HottestSitesModel

@end
@interface HottestSitesModel : JSONModel

@property (nonatomic, copy) NSString *cover_route_map_cover;
@property (nonatomic, copy) NSString *content_type;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *hid;
@property (nonatomic, strong) Location *location;
@property (nonatomic, copy) NSString <Optional>*name_zh;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *visited_count;
@property (nonatomic, copy) NSString *wish_to_go_count;
@property (nonatomic, copy) NSString <Optional>*name;

@end

@protocol ToolsModel
@end
@interface ToolsModel : JSONModel
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *url;
@end
@interface AllPlaceModel : JSONModel
@property (nonatomic, copy) NSString *visited_count;
@property (nonatomic, strong) NSArray <ToolsModel>*tools;
@property (nonatomic, copy) NSString *eid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *wish_to_go_count;
@property (nonatomic, copy) NSString *photo_count;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray <HottestSitesModel>*hottest_sites;
@property (nonatomic, strong) NSArray <HottestPlacesModel>*hottest_places;
@property (nonatomic, strong) Location *location;
@end
@interface PlaceDataModel : JSONModel
@property (nonatomic, copy) NSArray <PlaceModel>*data;
@end
