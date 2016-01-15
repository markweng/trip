//
//  TravelNotesModel.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "TravelNotesModel.h"

@implementation PoiModel
+ (JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary:@{@"description":@"descriptionp"}];
}
@end
@implementation WaypointsModel
@end
@implementation DaysModel
@end
@implementation NoteAuthorModel
@end
@implementation CoveredCountriesModel

@end
@implementation TravelNotesModel

@end
