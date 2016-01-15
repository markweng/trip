//
//  StoryViewCell.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HotSpotListModel;
typedef void(^StoryItemSelectBlock)(HotSpotListModel *model);
typedef void(^MoreActionBloak)(void);
@interface StoryViewCell : UITableViewCell
@property (copy, nonatomic)StoryItemSelectBlock storyItemSelectBlock;
@property (copy, nonatomic)MoreActionBloak moreActionBlock;
@property (strong, nonatomic) NSArray *storyModels;
@end
