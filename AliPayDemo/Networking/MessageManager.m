//
//  MessageManager.m
//  AliPayDemo
//
//  Created by heng chen on 2016/11/9.
//  Copyright © 2016年 James Hsu. All rights reserved.
//

#import "MessageManager.h"

static MessageManager *_messageManager = nil;

@implementation MessageManager

@synthesize httpManager;

// 封装网络请求的单例
+ (MessageManager *)shareMessageManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _messageManager = [[self alloc] init];
        
        _messageManager.httpManager = [HttpManager manager];
    });
    return _messageManager;
}

/**
 *  POST方法请求
 *
 *  @param URLString 请求的URL地址
 *  @param parameter 请求的参数
 *  @param success   请求成功的回调代码块
 *  @param failure   请求失败
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(returnBlock)success infoMessage:(returnBlock)info failure:(returnBlock)failure
{
    /// 断言判断urlstring 不为空
    NSAssert(URLString, @"urlstring must not be nil!");
    /// 拼接请求地址
    NSString *url = [NSString stringWithFormat:@"%@%@", SERVER, URLString];

    /// 接入AFNetworking请求
    
    [httpManager POST:url parameters:parameters success:^(BOOL sucessful, id objc) {
        
        if (sucessful) {
            
            /// 与后台约定返回的jsons数据格式
            if ([objc[@"code"] longValue]== 200) {
                
                /// 判断data 是否存在
                if (objc[@"data"]) {
                    success(YES, objc[@"data"]);
                }
                
                /// 判断是否有info
                if (objc[@"info"]) {
                    
                    if (!objc[@"data"]) {
                        success(YES,@"");
                    }
                    
                    info(YES,[NSString stringWithFormat:@"%@",objc[@"info"]]);
                    
                }
            }else
            {
                if (objc[@"info"]) {
                    
                    failure(NO,[NSString stringWithFormat:@"%@",objc[@"info"]]);
                    
                }
                
            }
            
        }
        
    } failure:^(BOOL sucessful, id objc) {
        
        failure(NO,objc);
        
    }];
}

@end
