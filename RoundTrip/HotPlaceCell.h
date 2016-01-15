//
//  HotPlaceCell.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/3.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HotPlaceTapDelegate <NSObject>

- (void)tapPictureAction:(NSInteger)tag;

@end
@interface HotPlaceCell : UITableViewCell
@property (nonatomic, strong) NSArray *placeArray;
@property (nonatomic, weak) id<HotPlaceTapDelegate>delegate;
@end
