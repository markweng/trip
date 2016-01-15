//
//  HomeDataModel.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "HomeDataModel.h"


@implementation LocationModel
@end

@implementation SearchElementModel
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"sid"}];
}
@end

@implementation SearchModel
@end

@implementation UserModel
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"uid"}];
}
@end

@implementation ElementDataModel
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"eid"}];
}
@end

@implementation HomeElementsModel
@end

@implementation HomeModel
@end

@implementation HomeDataModel
@end
