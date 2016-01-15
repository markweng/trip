//
//  UIViewController+UIViewController_MyPop.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/10.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "UIViewController+UIViewController_MyPop.h"
#import <objc/runtime.h>
@implementation UIViewController (UIViewController_MyPop)
- (void)setPopDelegate:(id<MyPopControllerDelegate>)popDelegate
{
    self.navigationController.popDelegate = popDelegate;
}

- (id<MyPopControllerDelegate>)popDelegate
{
    return self.navigationController.popDelegate;
}
@end
