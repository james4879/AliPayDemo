//
//  HttpManager.h
//  AliPayDemo
//
//  Created by heng chen on 2016/11/9.
//  Copyright © 2016年 James Hsu. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef void(^returnBlock)(BOOL sucessful, id objc);    /**< 请求完成的 callback */

@interface HttpManager : AFHTTPSessionManager

/**
 *  POST方法请求
 *
 *  @param URLString 请求的URL地址
 *  @param parameter 请求的参数
 *  @param success   请求成功的回调代码块
 *  @param failure   请求失败
 */
- (void)POST:(NSString *)URLString parameters:(id)parameters success:(returnBlock)success failure:(returnBlock)failure;

@end
