//
//  PicModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol PicInfoModel

@end
@interface PicInfoModel : JSONModel
@property (nonatomic, copy) NSString *photo_s;
@property (nonatomic, copy) NSString *trip_id;
@property (nonatomic, copy) NSString *trip_name;
@end
@interface PicModel : JSONModel
@property (nonatomic, strong) NSArray <PicInfoModel>*items;
@end
