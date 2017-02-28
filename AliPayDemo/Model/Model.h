//
//  Model.h
//  AliPayDemo
//
//  Created by heng chen on 2016/11/9.
//  Copyright © 2016年 James Hsu. All rights reserved.
//

#import "BaseModel.h"

#pragma mark - 这个 Model 是 viewModel 层的, 在这里实现网络请求的方法

@interface Model : BaseModel

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
                      studentName:(NSString *)studentName;

@end

#pragma mark - 这个 ModelAttribute 是网络请求所返回的数据, 可以包括基本数据类型和字典

@interface ModelAttribute : BaseModel

@property (nonatomic, strong) NSString *name;           /**< 姓名 */

@property (nonatomic, strong) NSString *age;            /**< 年龄 */

@end
