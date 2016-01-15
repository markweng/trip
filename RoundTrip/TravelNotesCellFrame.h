//
//  TravelNotesCellFrame.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/28.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define TEXYFONT [UIFont systemFontOfSize:14] 
@class WaypointsModel;
@interface TravelNotesCellFrame : NSObject
@property (nonatomic, assign) CGRect largeImageFrame;
@property (nonatomic, assign) CGRect linelabelFrame;
@property (nonatomic, assign) CGRect textLabelFrame;
@property (nonatomic, assign) CGRect clockImageFrame;
@property (nonatomic, assign) CGRect timeLabelFrame;
@property (nonatomic, assign) CGRect locationImageFrame;
@property (nonatomic, assign) CGRect locationLabelFrame;
@property (nonatomic, strong) WaypointsModel *model;
@property (nonatomic, assign) CGFloat cellHeight;
@end
