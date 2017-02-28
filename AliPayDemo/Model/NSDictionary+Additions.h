//
//  NSDictionary+Additions.h
//  AliPayDemo
//
//  Created by James Hsu on 1/24/17.
//  Copyright © 2017 James Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Additions)
/**
 * 基本数据类型
 */
- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue;
- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue;
- (float)getFloatValueForKey:(NSString *)key defaultValue:(float)defaultValue;
- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue;
- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue;
- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSURL *)getUrlValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue;
- (NSInteger)getIntegerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue;

/**
 * 数组
 */
- (NSArray *)getArrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue;
- (NSMutableArray *)getMutaArrayValueForKey:(NSString *)key defaultValue:(NSMutableArray *)defaultValue;
- (NSDictionary *)getDictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue;
- (NSMutableDictionary *)getMutaDictionaryValueForKey:(NSString *)key defaultValue:(NSMutableDictionary *)defaultValue;

@end
