//
//  PlaceTripItemModel.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/4.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceTripItemModel.h"



@implementation ItemModel

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"eid"}];
}

@end
@implementation PlaceTripItemModel

@end
