//
//  PlaceDetailViewCell.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/3.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PlaceTypeButtonDelegate <NSObject>

- (void)placeTypeButtonAction:(NSInteger)tag;

@end
@interface PlaceDetailViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *toolsArray;
@property (nonatomic, weak) id<PlaceTypeButtonDelegate>delegate;


@end
