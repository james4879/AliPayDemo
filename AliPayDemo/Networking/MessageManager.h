//
//  MessageManager.h
//  AliPayDemo
//
//  Created by heng chen on 2016/11/9.
//  Copyright © 2016年 James Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HttpManager.h"

#define SERVER @"http://apit.ifoodsoso.cn/api/" // 请更换自己的测试服务器地址

@interface MessageManager : NSObject

@property (nonatomic, strong) HttpManager *httpManager;

// 封装网络请求的单例
+ (MessageManager *)shareMessageManager;

/**
 *  POST方法请求
 *
 *  @param URLString 请求的URL地址
 *  @param parameter 请求的参数
 *  @param success   请求成功的回调代码块
 *  @param failure   请求失败
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(returnBlock)success infoMessage:(returnBlock)info failure:(returnBlock)failure;

@end
