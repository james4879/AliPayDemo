# AliPayDemo
支付宝 demo
 解压接口压缩文件(文件名是WS_MOBILE_PAY_SDK_BASE.zip),找到iOS的压缩文件(文件名是支付宝钱包支付开发包标准版(iOS).zip)

步骤1:  启动IDE(如Xcode),把iOS包中的压缩文件中以下文件拷贝到项目文件夹下,并导入到项目工程中。


步骤2:  在需要调用AlipaySDK的文件中,增加头文件引用。
           #import <AlipaySDK/AlipaySDK.h>


步骤3:  配置请求信息。


// 字典里面是你请求自己服务器的需要上传的参数(具体的业务可以和服务器端协商)

NSDictionary *parameters = @{@"payment_id":@"1",

@"paylist_id":@"1",

@"buyer_id":@"1",

@"buyer_name":@"james",

@"goods_amount":@"0.01",

@"type":@"json"};

AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

[manager POST:@"此处就是你要填写的项目服务器的支付接口(返回签名)" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {

NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData *)responseObject options:0 error:nil];

NSString *requestParameter = [dic objectForKey:@"data"];

// 返回签名的字符串

NSLog(@"data-->%@", requestParameter);

// 请求支付宝服务器

NSString *appScheme = @"AliPayDemo";

[[AlipaySDK defaultService] payOrder:requestParameter fromScheme:appScheme callback:^(NSDictionary *resultDic) {

NSLog(@"reslut --> %@", resultDic);

}];

} failure:^(AFHTTPRequestOperation *operation, NSError *error) {

NSLog(@"Error: %@", error);

}];

}
步骤4: 配置支付宝客户端返回url处理方法。


在项目APAppDelegate.m文件中,增加引用代码:

- (BOOL)application:(UIApplication *)application

openURL:(NSURL *)url

sourceApplication:(NSString *)sourceApplication

annotation:(id)annotation {

// 跳转支付宝钱包进行支付，处理支付结果

[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {

NSLog(@"result = %@",resultDic);

}];

return YES;

}
关于签名代码问题

(1)这些文件是为示例签名所在客户端本地使用。出于安全考虑,请商户尽量把私钥保

存在服务端,在服务端进行签名验签。

(2)如果遇到运行后报错,类似于以下提示信息:

Cannot find interface declaration for 'NSObject', superclass of 'Base64'
那么需要打开报错了的文件,增加头文件。

#import <Foundation/Foundation.h>
(3)如果商户要在某个文件中使用支付宝的开发包类库,需增加引用头文件。

#import <AlipaySDK/AlipaySDK.h>
(4)点击项目名称,点击“Build Settings”选项卡,在搜索框中,以关键字“search”

搜索,对“Header Search Paths”增加头文件路径:$(SRCROOT)/项目名

称。如果头文件信息已增加,可不必再增加。


增加头文件信息
(5)点击项目名称,点击“Build Phases”选项卡,在“Link Binary with Librarles”

选项中,新增“AlipaySDK.framework”和“SystemConfiguration.framework”

两个系统库文件。如果商户项目中已有这两个库文件,可不必再增加。




增加系统库文件
(6)点击项目名称,点击“Info”选项卡,在“URL Types”选项中,点击“+”,

在“URL Schemes”中输入“AliPayDemo”。“AliPayDemo”来自于文件

“APViewController.m”的NSString *appScheme = @"AliPayDemo";。




配置URL Schemes
此时得到的便是要请求给支付宝的全部数据


调用(AlipaySDK *)defaultService类下面的支付接口函数,唤起支付宝支付页面。

appScheme为app在info.plist注册的scheme。

[[AlipaySDK defaultService] payOrder:requestParameter fromScheme:appScheme callback:^(NSDictionary *resultDic) {

             NSLog(@"reslut --> %@", resultDic);

}];

支付宝支付页面
后面的动作全由买家在支付宝收银台中操作完成。如果设备中有支付宝客户端,会优先调用支付宝客户端进行支付,支付完成后会重新唤起商户app。


当这笔交易被买家支付成功后支付宝收银台上显示该笔交易成功,并提示用户“返回”。此时在APAppDelegate.m的-


(BOOL)application:(UIApplication )application openURL:(NSURL )url

sourceApplication:(NSString *)sourceApplication annotation:(id)annotation中调

用获取返回数据的代码:

// 跳转支付宝钱包进行支付，处理支付结果

[[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {

NSLog(@"result = %@",resultDic);

}];
// 点击取消后的返回

reslut = {

memo = "";

result = "";

resultStatus = 6001;

}
到这里 APP 集成支付宝已经完成了. 

在网上很多例子都是自己上传 order 的信息到服务器, 我这里都是交给服务器去解决, 服务器返回签名后直接丢给支付宝!嘿嘿...
