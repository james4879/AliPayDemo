//
//  NSDictionary+Additions.m
//  AliPayDemo
//
//  Created by James Hsu on 1/24/17.
//  Copyright © 2017 James Hsu. All rights reserved.
//

#import "NSDictionary+Additions.h"

@implementation NSDictionary (Additions)

#pragma mark - 基本数据类型

- (BOOL)getBoolValueForKey:(NSString *)key defaultValue:(BOOL)defaultValue {
    return [self objectForKey:key] == [NSNull null] ? defaultValue
    : [[self objectForKey:key] boolValue];
}

- (int)getIntValueForKey:(NSString *)key defaultValue:(int)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] intValue];
}

- (NSInteger)getIntegerValueForKey:(NSString *)key defaultValue:(NSInteger)defaultValue{
    return [self objectForKey:key] == [NSNull null] || ![self objectForKey:key]  ? defaultValue : [[self objectForKey:key] integerValue];
}

- (float)getFloatValueForKey:(NSString *)key defaultValue:(float)defaultValue {
    return [self objectForKey:key] == [NSNull null]
				? defaultValue : [[self objectForKey:key] floatValue];
}

- (time_t)getTimeValueForKey:(NSString *)key defaultValue:(time_t)defaultValue {
    NSString *stringTime   = [self objectForKey:key];
    if ((id)stringTime == [NSNull null]) {
        stringTime = @"";
    }
    struct tm created;
    time_t now;
    time(&now);
    
    if (stringTime) {
        if (strptime([stringTime UTF8String], "%a %b %d %H:%M:%S %z %Y", &created) == NULL) {
            strptime([stringTime UTF8String], "%a, %d %b %Y %H:%M:%S %z", &created);
        }
        return mktime(&created);
    }
    return defaultValue;
}

- (long long)getLongLongValueValueForKey:(NSString *)key defaultValue:(long long)defaultValue {
    return [self objectForKey:key] == [NSNull null]
    ? defaultValue : [[self objectForKey:key] longLongValue];
}

- (NSString *)getStringValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    NSString *string = [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [self objectForKey:key];
    
    if ([[self objectForKey:key] isKindOfClass:[NSString class]]) {
        if (string.description.length <= 0 || [[self objectForKey:key] isEqualToString:@"  "]) {
            string = defaultValue;
        }
    }else if ([[self objectForKey:key] isKindOfClass:[NSNumber class]])
    {
        string = [NSString stringWithFormat:@"%@",string];
    }
    
    return [NSString stringWithFormat:@"%@",string];
}

#pragma mark - 数组和对象

- (NSURL *)getUrlValueForKey:(NSString *)key defaultValue:(NSString *)defaultValue {
    NSString *url = [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ?defaultValue : [self objectForKey:key];
    
    return [NSURL URLWithString:url];
}

- (NSArray *)getArrayValueForKey:(NSString *)key defaultValue:(NSArray *)defaultValue {
    NSArray *array = [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [self objectForKey:key];
    
    return array;
}

- (NSMutableArray *)getMutaArrayValueForKey:(NSString *)key defaultValue:(NSMutableArray *)defaultValue {
    NSArray *array = [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [self objectForKey:key];
    
    if ([array isKindOfClass:[NSArray class]]) {
        return [NSMutableArray arrayWithArray:array];
    }
    
    return [NSMutableArray array];
}

- (NSDictionary *)getDictionaryValueForKey:(NSString *)key defaultValue:(NSDictionary *)defaultValue {
    NSDictionary *array = [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [self objectForKey:key];
    
    return array;
}

- (NSMutableDictionary *)getMutaDictionaryValueForKey:(NSString *)key defaultValue:(NSMutableDictionary *)defaultValue {
    NSDictionary *array = [self objectForKey:key] == nil || [self objectForKey:key] == [NSNull null] ? defaultValue : [self objectForKey:key];
    
    if ([array isKindOfClass:[NSDictionary class]]) {
        return [NSMutableDictionary dictionaryWithDictionary:array];
    }
    
    return [NSMutableDictionary dictionary];
}

@end
