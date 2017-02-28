//
//  BaseData.h
//  AliPayDemo
//
//  Created by James Hsu on 1/29/17.
//  Copyright © 2017 James Hsu. All rights reserved.
//

#import "FMDB.h"

// 数据库表名
#define UserTableName @"usertablename"

typedef NS_ENUM(NSUInteger, SQLtype) {
    SQLtypeInsert = 0,
    SQLtypeUpdate,
    SQLtypeQuery,
    SQLTypeDelete
};

typedef NS_ENUM(NSUInteger, ErrorCode)
{
    ErrorCodeUpdate = 1000,
    ErrorCodeInsert,
    ErrorCodeSearch,
    ErrorCodeDelete,
    ErrorCodeParameNULL
};

@class SQLModel;
/**
 * 数据实例
 */
typedef void(^FMDatabaseBlock)(BOOL ressult, SQLModel *sqlModel);

@interface BaseData : FMDatabaseQueue

@property (nonatomic, strong) SQLModel  * SqlModel;

/**
 *  操作数据库的回调
 *
 *  @param name   数据库表名
 *  @param parame 传入字典
 *  @param type   操作类型
 *  @param block  数据库实例对象
 */
- (void)executeUpdateWithTableName:(NSString *)name
                          withData:(NSDictionary *)parame
                           SQLType:(SQLtype)type
                          baseData:(FMDatabaseBlock)block;

/**
 *  查询数据库返回集合
 *
 *  @param name  数据库表名
 *  @param value  uid(当 uid 为空时返回当前所查询的表前十条数据, uid 有值返回 uid 等于 value 的数据)
 *
 *  @return  集合
 */
- (NSMutableArray *)queryTableWithName:(NSString *)name uidValue:(NSString *)value;

- (void)queryTableWithName:(NSString *)name
                  uidValue:(NSString *)value
                    listId:(NSString *)listId
                     limit:(NSInteger)limit
                  baseData:(FMDatabaseBlock)block;

- (NSDictionary *)searchTableName:(NSString *)name parame:(NSDictionary *)parame;

@end

@interface SQLModel : NSObject

@property (nonatomic, strong) NSArray       *results;

@property (nonatomic, assign) ErrorCode     errorCode;

@property (nonatomic, strong) NSString      *errorMessage;

@end
