//
//  BannerViewCell.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/26.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol TapImageProtocol <NSObject>
//
//- (void)TapImageAction:(CGFloat)offset;
//
//@end
@class HomeElementsModel;
@interface BannerViewCell : UITableViewCell
//@property (nonatomic, weak)id<TapImageProtocol>delegate;
@property (strong, nonatomic) HomeElementsModel *model;
@end
