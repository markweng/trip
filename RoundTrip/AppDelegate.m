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
#import <BmobSDK/Bmob.h>
#import "MyNetWorking.h"
#import "UMSocial.h"
#import "UMSocialSinaSSOHandler.h"
#import "UMSocialWechatHandler.h"

#import "AllUrl.h"
#define BMOB_KEY @"f8eed535e2a4a992bffd01ad503d65f6"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   [NSThread sleepForTimeInterval:3.0];
   [Bmob registerWithAppKey:BMOB_KEY];
   [UMSocialData setAppKey:UMENG_SHAREKEY];
   [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:@"987403555" secret:@"6c64d654f2f8b98018c36ac521f78b5e" RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    [UMSocialWechatHandler setWXAppId:@"wx195bfe3524440c76" appSecret:@"1ad889aab653b376085b208a12f03d84" url:nil];
    //设置所有状态栏的颜色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    //设置启动页状态了隐藏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    //设置网络状态监测
    [[MyNetWorking shareNet] setReachabilityMonitor];

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
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
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
