//
//  WantPlaceModel.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/4.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "SearchMoreModel.h"



@protocol PlaceElementModel
@end
@interface PlaceElementModel : JSONModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) NSArray <PlaceModel>*data;
@end

@interface WantPlaceModel : JSONModel
@property (nonatomic, strong) NSArray <PlaceElementModel>*elements;
@end
