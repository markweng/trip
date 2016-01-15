//
//  SearchMoreModel.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "SearchMoreModel.h"


@implementation TripsModel

+ (JSONKeyMapper *)keyMapper {
    
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"tid"}];
}

@end

@implementation PlaceModel


+ (JSONKeyMapper *)keyMapper {


    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"pid"}];
}

@end
@implementation SearchDataModel



@end
@implementation CountryModel

+ (JSONKeyMapper *)keyMapper {
 
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"cid"}];
}

@end
@implementation SearchMoreModel

@end
