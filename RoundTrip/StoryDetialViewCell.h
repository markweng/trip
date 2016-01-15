//
//  StoryDetialViewCell.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoryDetialViewCellFrame;
@interface StoryDetialViewCell : UITableViewCell
@property (assign, nonatomic) StoryDetialViewCellFrame *cellFrame;
@property (strong, nonatomic) UIImageView *largeImageView;
@end
