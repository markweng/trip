//
//  UIViewController+UIViewController_MyPop.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/10.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+MyPop.h"
@interface UIViewController (UIViewController_MyPop)
/**
 *  pop delegate
 */
@property (assign,nonatomic) id<MyPopControllerDelegate> popDelegate;
@end
