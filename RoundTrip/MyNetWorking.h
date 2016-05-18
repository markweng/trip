//
//  MyNetWorking.h
//  zhixueParent
//
//  Created by 翁成 on 16/4/28.
//  Copyright © 2016年 com.wong. All rights reserved.
//

#import <Foundation/Foundation.h>



@class Reachability;

@interface MyNetWorking : NSObject

//网络监听需要用到的三个属性
@property(strong,nonatomic)Reachability *hostReach;
@property(assign,nonatomic)BOOL isReachable;
@property(assign,nonatomic)BOOL conFlag;

//设置网络监听
-(void)setReachabilityMonitor;


+ (MyNetWorking *)shareNet;

@end
