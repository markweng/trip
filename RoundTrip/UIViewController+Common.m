//
//  UIViewController+Common.m
//  RoundTrip
//
//  Created by 翁成 on 16/5/26.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "UIViewController+Common.h"
#import "MBProgressHUD.h"

@implementation UIViewController (Common)

- (void)showHudWithTitle:(NSString *)title {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window animated:YES];
    HUD.labelText = title;
    HUD.labelFont = [UIFont systemFontOfSize:14];
    HUD.mode = MBProgressHUDModeText;
    [HUD hide:YES afterDelay:2];
    
}

@end
