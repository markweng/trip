//
//  StroyCell.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/8.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^DisLikeBlock)(void);
@class ItemModel;

@interface StroyCell : UITableViewCell
@property (nonatomic, strong) ItemModel *model;
@property (nonatomic, copy)DisLikeBlock block;
@end
