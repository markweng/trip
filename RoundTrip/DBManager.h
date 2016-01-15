//
//  DBManager.h
//  RoundTrip
//
//  Created by 翁成 on 16/1/7.
//  Copyright © 2016年 wong. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 数据管理
 按照单例设计模式 进行 设计
 存储 收藏/下载/浏览记录
 //增删改查数据
 */

#import "FMDatabase.h"

@interface DBManager : NSObject
//非标准单例
+ (DBManager *)sharedManager;
//增加 数据 收藏/浏览/下载记录


//存储类型 favorites downloads browses
- (void)insertModel:(id)model;
- (void)insertTripModel:(id)model;
//删除指定的应用数据 根据指定的类型
- (void)deleteModelForPid:(NSString *)pid;
- (void)deleteModelForTripid:(NSString *)tripid;


//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistInfoForid:(NSString *)pid tripid:(NSString *)tripid;
//根据 指定的记录类型  返回 记录的条数
- (NSInteger)getCountsFromAppWithRecordType:(NSString *)type;

- (NSArray *)readModelsWithRecordType:(NSString *)type;

@end
