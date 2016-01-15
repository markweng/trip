//
//  StoryDetialViewCellFrame.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define TEXYFONT [UIFont systemFontOfSize:14] 
@class DetailListModel;
@interface StoryDetialViewCellFrame : NSObject
@property (nonatomic, assign) CGRect timeImageFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGRect largeImageViewFrme;
@property (nonatomic, assign) CGRect contentLabelFrame;
@property (nonatomic, assign) CGFloat cellHeight;
@property (strong, nonatomic) DetailListModel *model;
@end
