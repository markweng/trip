//
//  PlaceTripItemModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/4.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol ItemModel

@end

@interface ItemModel : JSONModel
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *cover_image;
@property (nonatomic, copy) NSString *eid;
@property (nonatomic, copy) NSString <Optional>*text;
@property (nonatomic, copy) NSString <Optional>*index_cover;
@property (nonatomic, copy) NSString <Optional>*share_url;
@end

@interface PlaceTripItemModel : JSONModel
@property (nonatomic, strong) NSArray <ItemModel>*items;
@end
