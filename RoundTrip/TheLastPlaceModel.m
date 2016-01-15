//
//  TheLastPlaceModel.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/5.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "TheLastPlaceModel.h"

@implementation TheLastPlaceModel
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"eid",@"description":@"mydescription"}];
}
@end
@implementation HotTestPlaseModel



@end