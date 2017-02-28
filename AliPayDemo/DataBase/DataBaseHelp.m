//
//  DataBaseHelp.m
//  AliPayDemo
//
//  Created by James Hsu on 1/29/17.
//  Copyright © 2017 James Hsu. All rights reserved.
//

#import "DataBaseHelp.h"
#import <FMDB/FMDB.h>

#define FilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"user.sqlite"]

@interface DataBaseHelp ()

@property (nonatomic, strong) BaseData* queue;

@end

@implementation DataBaseHelp

/**
 * 创建数据库
 */
- (id)init
{
    self = [super init];
    
    if(self){
        _queue = [BaseData databaseQueueWithPath:FilePath];
    }
    return self;
}

/**
 * 数据库的单例
 */
+ (DataBaseHelp *)sharedInstance
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        
        _sharedObject = [[self alloc] init];
    
    });
    return _sharedObject;
}

/**
 * 操作数据库的回调
 */
- (void)inDatabase:(void(^)(FMDatabase*))block
{
    [_queue inDatabase:^(FMDatabase *db){
        
        block(db);
    }];
}

/**
 *  数据库操作  异步
 *
 *  @param name   数据库表名
 *  @param parame 传入字典
 *  @param type   操作类型
 *  @param block  是否操作成功
 */
- (void)executeUpdateWithTableName:(NSString *)name withData:(NSDictionary *)parame SQLType:(SQLtype)type baseData:(FMDatabaseBlock)block
{
    [_queue executeUpdateWithTableName:name withData:parame SQLType:type baseData:^(BOOL ressult, SQLModel *objc) {
        if (block) {
            block(ressult, objc);
        }
    }];
}

/**
 * 查找专用
 * @param value  -- uid 唯一标示
 * @param listId -- 主键 序列号（最后一个序列号)
 * @param limit  -- 每次取得个数
 */
- (void)searchTableName:(NSString *)name withUid:(NSString *)value listId:(NSString *)listId limit:(NSInteger)limit baseData:(FMDatabaseBlock)block
{
    [_queue queryTableWithName:name uidValue:value listId:listId limit:limit baseData:^(BOOL ressult, SQLModel *sqlModel) {
        if (block) {
            block(ressult, sqlModel);
        }
    }];
}

/// 根据uid 查找
- (NSDictionary *)searchUserWithUid:(NSString *)uid
{
    NSArray *results = [_queue queryTableWithName:UserTableName uidValue:uid];
    
    if (results && results.count > 0) {
        return [results lastObject];
    }
    
    return nil;
}

/// 查找数据
- (NSDictionary *)searchTableName:(NSString *)name withData:(NSDictionary *)parame
{
    return [_queue searchTableName:name parame:parame];
}

@end
