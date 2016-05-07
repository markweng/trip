//
//  AppDelegate.m
//  RoundTrip
//
//  Created by 翁成 on 15/12/23.
//  Copyright © 2015年 wong. All rights reserved.
//

#import "AppDelegate.h"
#import <MMDrawerController/MMDrawerController.h>
#import "LeftViewController.h"
#import "UIView+Common.h"
#import "HomeViewController.h"
#import "GuoNeiViewController.h"
#import "GuoWaiViewController.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // [NSThread sleepForTimeInterval:3.0];
    
    //设置所有状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置启动页状态了隐藏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    _homeViewController = [[HomeViewController alloc] init];
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:_homeViewController];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    LeftViewController *leftDrawer = [[LeftViewController alloc] init];
   
    MMDrawerController  *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navController leftDrawerViewController:leftDrawer];
    CGFloat width = screenWidth();
    // 设置左边视图窗口的大小
    drawerController.maximumLeftDrawerWidth = width/5*4;
    // 设置是否显示阴影
    drawerController.showsShadow = NO;
    // 设置打开抽屉的手势(全部)
    drawerController.openDrawerGestureModeMask = MMCloseDrawerGestureModeNone;
    // 设置关闭抽屉的手势
    drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModePanningCenterView|MMCloseDrawerGestureModePanningDrawerView;
    self.window.rootViewController = drawerController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}
- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  
}

- (void)applicationWillTerminate:(UIApplication *)application {
  
}

@end
