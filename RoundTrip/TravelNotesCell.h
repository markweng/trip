//
//  TravelNotesCell.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TravelNotesCellFrame;
@interface TravelNotesCell : UITableViewCell
@property (nonatomic, strong) TravelNotesCellFrame *cellFrame;
@property (nonatomic, strong) UIImageView *largeImageView;
@end
