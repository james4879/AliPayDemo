//
//  Model.m
//  AliPayDemo
//
//  Created by heng chen on 2016/11/9.
//  Copyright © 2016年 James Hsu. All rights reserved.
//

#import "Model.h"
#import "MessageManager.h"
#import <AlipaySDK/AlipaySDK.h>

@implementation Model

/**
 *  支付宝接口
 *  HTTP请求方式          POST
 */
- (void)configAlipayWithPayTypeID:(NSString *)paytypeID
                        studentID:(NSString *)studentID
                            price:(NSString *)price
                      description:(NSString *)description
                            title:(NSString *)title
                    studentAvatar:(NSString *)studentAvatar
                       schoolName:(NSString *)schoolName
                      studentName:(NSString *)studentName
{
    NSString *name = @"pay";
    
    NSDictionary *parame = @{
                             @"access_token"    : @"6acd2005bb519dfb4d5f9e0d3cb6d760",
                             @"method"          : @"POST",
                             @"open_id"         : @"rWGSQpLqNpuzVW1CQWGGjWruRWayNpLqX",
                             @"uid"             : @"147",
                             @"payment_id"      : @"1",
                             @"paytype_id"      : paytypeID,
                             @"student_id"      : studentID,
                             @"price"           : price,
                             @"description"     : description,
                             @"title"           : title,
                             @"student_avatar"  : studentAvatar,
                             @"school_name"     : schoolName,
                             @"student_name"    : studentName
                             };

    [[MessageManager shareMessageManager] POST:name parameters:parame success:^(BOOL sucessful, id objc) {
        
        // 请求支付宝服务器
        NSString *appScheme = @"AliPayDemo";
        
        if (![objc isKindOfClass:[NSDictionary class]]) {
            [self enterAlertView:@"返回数据格式出错"];
            return;
        }
        
        NSString *signParam = [objc valueForKey:@"sign"];
        
        [[AlipaySDK defaultService] payOrder:signParam fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
            NSString *result = [resultDic objectForKey:@"result"];
            
            if ([resultStatus isEqualToString:@"9000"]) {
                
                NSRange range = [result rangeOfString:@"true"];
                result = [result substringWithRange:range];
                
                if ([result isEqualToString:@"true"]) {
                    NSLog(@"订单支付成功");
                    [self enterAlertView:@"支付成功"];
                    return;
                }
            }else if ([resultStatus isEqualToString:@"8000"]) {
                NSLog(@"正在处理中");
                [self enterAlertView:@"支付处理中"];
                
            } else if ([resultStatus isEqualToString:@"4000"]) {
                NSLog(@"订单支付失败");
                [self enterAlertView:@"订单支付失败"];
                
            } else if ([resultStatus isEqualToString:@"6001"]) {
                NSLog(@"用户中途取消");
                [self enterAlertView:@"用户取消"];
                
            } else if ([resultStatus isEqualToString:@"6002"]) {
                NSLog(@"网络连接出错");
                [self enterAlertView:@"网络连接出错"];
            }
        }];
        
    } infoMessage:^(BOOL sucessful, id objc) {
        
        self.messageInfo(objc);
        [self enterAlertView:objc];
     
    } failure:^(BOOL sucessful, id objc) {
        
        self.failureBlock(objc);
        [self enterAlertView:objc];
     
    }];
}

/**
 *  支付状态
 *
 *  @param message 状态名称
 */
- (void)enterAlertView:(NSString *)message
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    [alert show];
}

@end

@implementation ModelAttribute

+ (id)instanceModelWithDictionary:(NSDictionary *)dic
{
    ModelAttribute *model = [[ModelAttribute alloc] init];
    
    if (dic) {
        model.name = [dic getStringValueForKey:@"name" defaultValue:@""]; //网络请求返回的 name 默认为空字符串
        model.age  = [dic getStringValueForKey:@"age" defaultValue:@""];
    }
    
    return   model;
}

@end
