//
//  UIView+Common.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/23.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "UIView+Common.h"

@implementation UIView (Common)
CGFloat screenWidth() {
    return [[UIScreen mainScreen] bounds].size.width;
}
CGFloat screenHeight() {
    return [[UIScreen mainScreen] bounds].size.height;
}

CGFloat getMinX(UIView *view) {
    return CGRectGetMinX(view.frame);
}

CGFloat getMaxX(UIView *view) {
    return CGRectGetMaxX(view.frame);
}

CGFloat getMinY(UIView *view) {
    return CGRectGetMinY(view.frame);
}

CGFloat getMaxY(UIView *view) {
    return CGRectGetMaxY(view.frame);
}
CGFloat getMaxXForFrame(CGRect frame) {
    return CGRectGetMaxX(frame);
}
CGFloat getMaxYForFrame(CGRect frame) {
    return CGRectGetMaxY(frame);
}
CGFloat width(UIView *view) {
    return CGRectGetWidth(view.frame);
}

CGFloat height(UIView *view) {
    return CGRectGetHeight(view.frame);
}
@end
