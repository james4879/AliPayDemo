//
//  HttpManager.m
//  AliPayDemo
//
//  Created by heng chen on 2016/11/9.
//  Copyright © 2016年 James Hsu. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

/**
 *  POST方法请求
 *
 *  @param URLString 请求的URL地址
 *  @param parameter 请求的参数
 *  @param success   请求成功的回调代码块
 *  @param failure   请求失败
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(returnBlock)success failure:(returnBlock)failure
{
    //设置请求格式，格式为字典 k-v
    self.requestSerializer = [AFHTTPRequestSerializer serializer];
    
    //设置返回格式 为解析好的json
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    
    /// 设置请求时间为30s
    self.requestSerializer.timeoutInterval = 30;
    
    self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",@"text/html",@"text/json", @"text/plain", nil];
    
    [self POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (responseObject) {
            success(YES, responseObject);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (error) {
            failure(NO,@"服务器开小差了!");
        }
    }];
}

@end
