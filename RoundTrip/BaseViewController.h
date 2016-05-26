//
//  BaseViewController.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/27.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface BaseViewController : UIViewController
@property (nonatomic, copy) NSString *titleString;
- (void)customNavigationBar;
- (void)backAction;
- (void)showHudWithTitle:(NSString *)title;
@end
