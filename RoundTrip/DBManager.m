//
//  DBManager.m
//  RoundTrip
//
//  Created by 翁成 on 16/1/7.
//  Copyright © 2016年 wong. All rights reserved.
//

#import "DBManager.h"
#import "ListStoryModel.h"
#import "PlaceTripItemModel.h"
/*
 数据库
 1.导入 libsqlite3.dylib
 2.导入 fmdb
 3.导入头文件
 fmdb 是对底层C语言的sqlite3的封装
 
 */
@implementation DBManager
{
    //数据库对象
    FMDatabase *_database;
}

+ (DBManager *)sharedManager {
    static DBManager *manager = nil;
    @synchronized(self) {//同步 执行 防止多线程操作
        if (manager == nil) {
            manager = [[DBManager alloc] init];
        }
    }
    return manager;
}
- (id)init {
    if (self = [super init]) {
        //1.获取数据库文件app.db的路径
        NSString *filePath = [self getFileFullPathWithFileName:@"app.db"];
        //2.创建database
        _database = [[FMDatabase alloc] initWithPath:filePath];
        //3.open
        //第一次 数据库文件如果不存在那么 会创建并且打开
        //如果存在 那么直接打开
        if ([_database open]) {
            NSLog(@"数据库打开成功");
            //创建表 不存在 则创建
            [self creatTable];
        }else {
            NSLog(@"database open failed:%@",_database.lastErrorMessage);
        }
    }
    return self;
}

//@property (copy, nonatomic) NSString *index_cover;
//@property (copy, nonatomic) NSString *index_title;
//@property (copy, nonatomic) NSString *view_count;
//@property (copy, nonatomic) NSString *spot_id;
//@property (nonatomic, strong) UserNameModel *user;
#pragma mark - 创建表
- (void)creatTable {
    
    NSString *sql1 = @"create table if not exists FavoriteStory(serial integer  Primary Key Autoincrement,index_cover Varchar(1024),index_title Varchar(1024),view_count Varchar(1024),spot_id Varchar(1024),type Varchar(1024))";
    
    NSString *sql2 = @"create table if not exists TripNote(serial integer Primary Key Autoincrement,name Varchar(1024),cover_image Varchar(1024),tripid Varchar(1024),type Varchar(1024))";
    
    BOOL isSuccees = [_database executeUpdate:sql1]&&[_database executeUpdate:sql2];
    
    if (!isSuccees) {
        NSLog(@"creatTable error:%@",_database.lastErrorMessage);
    }
    
}
#pragma mark - 获取文件的全路径

//获取文件在沙盒中的 Documents中的路径
- (NSString *)getFileFullPathWithFileName:(NSString *)fileName {
    NSString *docPath = [NSHomeDirectory() stringByAppendingFormat:@"/Documents"];
    NSFileManager *fm = [NSFileManager defaultManager];
    if ([fm fileExistsAtPath:docPath]) {
        //文件的全路径
        return [docPath stringByAppendingFormat:@"/%@",fileName];
    }else {
        //如果不存在可以创建一个新的
        NSLog(@"Documents不存在");
        return nil;
    }
}

- (void)insertModel:(id)model {
    HotSpotListModel *hotSpotListModel = (HotSpotListModel *)model;
    if ([self isExistInfoForid:hotSpotListModel.spot_id tripid:nil]) {
        NSLog(@"this app has  recorded");
        return;
    }
    NSString *sql = @"insert into FavoriteStory(index_cover,index_title,view_count,spot_id,type) values (?,?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sql,hotSpotListModel.index_cover,hotSpotListModel.index_title,hotSpotListModel.view_count,hotSpotListModel.spot_id,@"story"];
    if (!isSuccess) {
        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
}
- (void)insertTripModel:(id)model {
    
    ItemModel *itemModel = (ItemModel *)model;
    if ([self isExistInfoForid:nil tripid:itemModel.eid]) {
        NSLog(@"this app has  recorded");
        return;
    }
    
    NSString *sql = @"insert into TripNote(name,cover_image,tripid,type) values (?,?,?,?)";
    BOOL isSuccess = [_database executeUpdate:sql,itemModel.name ,itemModel.cover_image,itemModel.eid,@"trip"];
    if (!isSuccess) {
        NSLog(@"insert error:%@",_database.lastErrorMessage);
    }
    
}
//删除指定的应用数据 根据指定的类型
- (void)deleteModelForPid:(NSString *)pid  {
    NSString *sql = @"delete from FavoriteStory where spot_id = ?";
    BOOL isSuccess = [_database executeUpdate:sql,pid];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}
- (void)deleteModelForTripid:(NSString *)tripid {
    
    NSString *sql = @"delete from TripNote where tripid = ?";
    BOOL isSuccess = [_database executeUpdate:sql,tripid];
    if (!isSuccess) {
        NSLog(@"delete error:%@",_database.lastErrorMessage);
    }
}

//根据记录类型 查找 指定的记录

- (NSArray *)readModelsWithRecordType:(NSString *)type {
    
    // TripNote
    FMResultSet * rs = nil;
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合
    
    if ([type isEqualToString:@"story"]) {

        NSString *sql = @"select * from FavoriteStory where type = ?";
        rs = [_database executeQuery:sql,type];
        while ([rs next]) {
            //把查询之后结果 放在model
            ItemModel *model = [[ItemModel alloc] init];
            
            model.cover_image = [rs stringForColumn:@"index_cover"];
            model.name = [rs stringForColumn:@"index_title"];
            model.eid = [rs stringForColumn:@"spot_id"];
            //放入数组
            [arr addObject:model];
        }
        return arr;
    } else {
        
        NSString *sql = @"select * from TripNote where type = ?";
        
        rs = [_database executeQuery:sql,type];
        while ([rs next]) {
            //把查询之后结果 放在model
            ItemModel *model = [[ItemModel alloc] init];
            
            model.cover_image = [rs stringForColumn:@"cover_image"];
            model.name = [rs stringForColumn:@"name"];
            model.eid = [rs stringForColumn:@"tripid"];
            //放入数组
            [arr addObject:model];
        }
        return arr;
        
    }
    
}
- (NSArray *)readModelsWithRecordTripId:(NSString *)TripId {
    NSString *sql = @"select * from Steps where  TripNote = ?";
    FMResultSet * rs = [_database executeQuery:sql,TripId];
    
    NSMutableArray *arr = [NSMutableArray array];
    //遍历集合
    
    while ([rs next]) {
        //把查询之后结果 放在model
        ItemModel *model = [[ItemModel alloc] init];
        
        model.cover_image = [rs stringForColumn:@"name"];
        model.name = [rs stringForColumn:@"cover_image"];
        model.eid = [rs stringForColumn:@"tripid"];
        //放入数组
        [arr addObject:model];
    }
    return arr;
}
//根据指定的类型 返回 这条记录在数据库中是否存在
- (BOOL)isExistInfoForid:(NSString *)pid tripid:(NSString *)tripid {
    NSString *sql;
    FMResultSet *rs = nil;
    if (pid) {
        sql = @"select * from FavoriteStory where spot_id = ?";
        rs = [_database executeQuery:sql,pid];
    } else {
        
        sql = @"select * from TripNote where tripid = ?";
        rs = [_database executeQuery:sql,tripid];
        
    }
    
    
    if ([rs next]) {//查看是否存在 下条记录 如果存在 肯定 数据库中有记录
        return YES;
    }else{
        return NO;
    }
}
//根据 指定的记录类型  返回 记录的条数
- (NSInteger)getCountsFromAppWithRecordType:(NSString *)type {
    NSString *sql = @"select count(*) from Recipes where recordType = ?";
    FMResultSet *rs = [_database executeQuery:sql,type];
    NSInteger count = 0;
    while ([rs next]) {
        //查找 指定类型的记录条数
        count = [[rs stringForColumnIndex:0] integerValue];
    }
    return count;
}



@end
