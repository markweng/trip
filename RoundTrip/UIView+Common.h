//
//  UIView+Common.h
//  RoundTrip
//
//  Created by 翁成 on 15/12/23.
//  Copyright © 2015年 wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Common)

/**
 *  返回屏幕的宽
 *
 *  @return 当前视图的 width
 */
CGFloat screenWidth();
/**
 *  返回屏幕的高
 *
 *  @return 当前视图的 height
 */
CGFloat screenHeight();
/**
 *  获取视图最大的 X
 *
 *  @param view 当前视图
 *
 *  @return 最大的 X
 */
CGFloat getMaxX(UIView *view);
/**
 *  获取视图最小的 X
 *
 *  @param view 当前视图
 *
 *  @return 最小的 X
 */
CGFloat getMinX(UIView *view);
/**
 *  获取视图最大的 Y
 *
 *  @param view 当前视图
 *
 *  @return 最大的 Y
 */

CGFloat getMaxXForFrame(CGRect frame);
/**
 *  获取最大的 X
 *
 *  @param view 当前frame
 *
 *  @return 最大的 X
 */
CGFloat getMaxYForFrame(CGRect frame);
/**
 *  获取最大的 Y
 *
 *  @param view 当前frame
 *
 *  @return 最大的 Y
 */
CGFloat getMaxY(UIView *view);
/**
 *  获取视图最小的 Y
 *
 *  @param view 当前视图
 *
 *  @return 最小的 Y
 */
CGFloat getMinY(UIView *view);
/**
 *  计算视图的宽
 *
 *  @param view 当前视图
 *
 *  @return 视图的宽
 */
CGFloat width(UIView *view);

/**
 *  计算视图的高
 *
 *  @param view 当前视图
 *
 *  @return 视图的高
 */
CGFloat height(UIView *view);

@end
