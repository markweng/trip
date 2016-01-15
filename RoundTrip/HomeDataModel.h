//
//  HomeDataModel.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>


//经纬度
@interface LocationModel : JSONModel
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *lng;
@end

//搜索内容
@protocol SearchElementModel
@end
@interface SearchElementModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *wish_to_go_count;
@property (nonatomic, copy) NSString *name_orig;
@property (nonatomic, copy) NSString *visited_count;
@property (nonatomic, copy) NSString <Optional>*name_zh;
@property (nonatomic, copy) NSString <Optional>*name_en;
@property (nonatomic, copy) NSString <Optional>*slug_url;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *sid;
@property (nonatomic, strong) LocationModel *location;
@end

//搜索
@protocol SearchModel
@end
@interface SearchModel : JSONModel
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <SearchElementModel> *elements;
@end

//用户信息
@interface UserModel : JSONModel
@property (nonatomic, copy) NSString *location_name;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *resident_city_id;
@property (nonatomic, copy) NSString *avatar_m;
@property (nonatomic, copy) NSString *cover;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *country_num;
@property (nonatomic, copy) NSString *avatar_s;
@property (nonatomic, copy) NSString *avatar_l;
@property (nonatomic, copy) NSString *country_code;
@property (nonatomic, copy) NSString *user_desc;
@end


//元素内容
@protocol ElementDataModel
@end
@interface ElementDataModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*text;
@property (nonatomic, copy) NSString <Optional>*index_cover;
@property (nonatomic, copy) NSString <Optional>*cover_image_height;
@property (nonatomic, copy) NSString <Optional>*trip_id;
@property (nonatomic, copy) NSString <Optional>*index_title;
@property (nonatomic, copy) NSString <Optional>*view_count;
@property (nonatomic, copy) NSString <Optional>*cover_image_1600;
@property (nonatomic, copy) NSString <Optional>*cover_image_s;
@property (nonatomic, copy) NSString <Optional>*share_url;
@property (nonatomic, copy) NSString <Optional>*timezone;
@property (nonatomic, copy) NSString <Optional>*date_tour;
@property (nonatomic, copy) NSString <Optional>*is_hiding_location;
@property (nonatomic, copy) NSString <Optional>*spot_id;
@property (nonatomic, copy) NSString <Optional>*cover_image_w640;
@property (nonatomic, copy) NSString <Optional>*comments_count;
@property (nonatomic, copy) NSString <Optional>*cover_image;
@property (nonatomic, copy) NSString <Optional>*cover_image_width;
@property (nonatomic, copy) NSString <Optional>*recommendations_count;
@property (nonatomic, copy) NSString <Optional>*title;
//横幅
@property (nonatomic, copy) NSString <Optional>*image_url;
@property (nonatomic, copy) NSString <Optional>*html_url;

@property (nonatomic, copy) NSString <Optional>*cover_image_default;
@property (nonatomic, strong) UserModel <Optional>*user;

@property (nonatomic, copy) NSString <Optional>*name;
@property (nonatomic, copy) NSString <Optional>*day_count;
@property (nonatomic, copy) NSString <Optional>*first_day;
@property (nonatomic, copy) NSString <Optional>*popular_place_str;
@property (nonatomic, copy) NSString <Optional>*eid;

@end

//主页元素
@protocol HomeElementsModel
@end
@interface HomeElementsModel : JSONModel
@property (nonatomic, copy) NSString <Optional>*type;
@property (nonatomic, copy) NSString <Optional> *desc;
@property (nonatomic, strong) NSArray <ElementDataModel,Optional> *data;
@end

//主页内容
@interface HomeDataModel : JSONModel
@property (nonatomic, strong) NSArray <SearchModel,Optional> *search_data;
@property (nonatomic, strong) NSArray <HomeElementsModel> *elements;
@property (nonatomic, copy) NSString *next_start;
@end

//主页
@interface HomeModel : JSONModel
@property (nonatomic, strong) HomeDataModel *data;
@end
