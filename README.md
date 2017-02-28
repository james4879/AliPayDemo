集成流程

步骤1:

启动IDE(如Xcode),把iOS包中的压缩文件中以下文件拷贝到项目文件夹下,并导入到项目工程中
步骤2:

在需要调用AlipaySDK的文件中,增加头文件引用。#import <AlipaySDK/AlipaySDK.h>
步骤3:

配置请求信息。
NSString *name = @"pay";
NSDictionary *parame = @{ 
                           @"paytype_id"      : paytypeID,
                           @"student_id"      : studentID,
                           @"price"           : price,
                           @"description"     : description,
                           @"title"           : title,
                           @"student_avatar"  : studentAvatar,
                           @"school_name"     : schoolName,
                           @"student_name"    : studentName
                           };
NSString *appScheme = @"AliPayDemo";
if (![objc isKindOfClass:[NSDictionary class]]) {
    NSLog(@"返回数据格式出错");
    return;
}
NSString *signParam = [objc valueForKey:@"sign"];
// 请求支付宝服务器
[[AlipaySDK defaultService] payOrder:signParam 
                          fromScheme:appScheme 
                            callback:^(NSDictionary *resultDic) {
NSString *resultStatus = [resultDic objectForKey:@"resultStatus"];
NSString *result       = [resultDic objectForKey:@"result"];
if ([resultStatus isEqualToString:@"9000"]) {
    NSRange range = [result rangeOfString:@"true"];
    result        = [result substringWithRange:range];
    if ([result isEqualToString:@"true"]) {
        NSLog(@"订单支付成功");
        return;
      }
   } 
}];
步骤4:

配置支付宝客户端返回url处理方法。
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
   // 跳转支付宝钱包进行支付，处理支付结果
   [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
       NSLog(@"result = %@", resultDic);
   }];
   return YES;
}

在网上很多例子都是自己上传 order 的信息到服务器, 我这里都是交给服务器去解决, 服务器返回签名后直接丢给支付宝!嘿嘿...
