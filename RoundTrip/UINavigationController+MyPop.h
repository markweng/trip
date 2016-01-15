//
//  UINavigationController+MyPop.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/10.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyPopControllerDelegate <NSObject>
@optional
- (BOOL)MyPopGestureTouchView:(UIView *)view;
@end
@interface UINavigationController (MyPop)
/**
 *  pop delegate
 */
@property (assign,nonatomic) id<MyPopControllerDelegate> popDelegate;
@end
