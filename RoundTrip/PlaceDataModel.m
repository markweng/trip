//
//  PlaceDataModel.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "PlaceDataModel.h"

@implementation HottestPlacesModel



@end
@implementation HottestSitesModel

+ (JSONKeyMapper *)keyMapper {
    
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"hid"}];
}

@end
@implementation Location



@end

@implementation ToolsModel

@end
@implementation PlaceDataModel

@end
@implementation AllPlaceModel
+ (JSONKeyMapper *)keyMapper {
    
    
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"id":@"eid"}];
}
@end