//
//  GuoNeiViewCell.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/2.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define IMAGE_HEIGHT 200
#define IMAGE_OFFSET_SPEED 25
@class PlaceModel;
@interface GuoNeiViewCell : UICollectionViewCell
@property (nonatomic, assign, readwrite) CGPoint imageOffset;
@property (nonatomic, strong) PlaceModel *model;
@end
