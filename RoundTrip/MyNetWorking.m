//
//  MyNetWorking.m
//  zhixueParent
//
//  Created by 翁成 on 16/4/28.
//  Copyright © 2016年 com.wong. All rights reserved.
//

#import "MyNetWorking.h"
#import "Reachability.h"
#import "MBProgressHUD.h"


static MyNetWorking *net = nil;

@implementation MyNetWorking
+ (MyNetWorking *)shareNet
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        net = [[MyNetWorking alloc] init];
        
    });
    
    return net;
}


#pragma mark 设置网络监听
-(void)setReachabilityMonitor
{
    //开启网络状况的监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"] ;
    [self.hostReach startNotifier];  //开始监听，会启动一个run loop
}

//网络链接改变时会调用的方法
-(void)reachabilityChanged:(NSNotification *)note
{
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    
    //对连接改变做出响应处理动作
    NetworkStatus status = [currReach currentReachabilityStatus];
    //如果没有连接到网络就弹出提醒实况
    //    self.isReachable = YES;
    if(status == NotReachable)
    {
        
        self.isReachable = NO;

        UIWindow *window = [[UIApplication sharedApplication] keyWindow];
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:window.rootViewController.view animated:YES];
        HUD.labelText = @"未连接到网络";
        HUD.labelFont = [UIFont systemFontOfSize:14];
        HUD.mode = MBProgressHUDModeText;
        [HUD hide:YES afterDelay:5];

        self.conFlag = NO;
        
    }
    else if(status == ReachableViaWiFi){
        
        NSLog(@"wifi");
        self.isReachable = YES;
        self.conFlag = YES;
        
        
    }else if(status == ReachableViaWWAN)
    {
        NSLog(@"3G");
        self.isReachable = YES;
        self.conFlag = YES;
        
    }
}

////取消网络请求
//- (void)cancelNetWork
//{
//    if (manager) {
//        
//        [manager.operationQueue cancelAllOperations];
//        
//    }
//}

@end
