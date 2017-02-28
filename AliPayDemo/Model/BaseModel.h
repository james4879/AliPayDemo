//
//  BaseModel.h
//  AliPayDemo
//
//  Created by James Hsu on 1/24/17.
//  Copyright © 2017 James Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSDictionary+Additions.h"
#import "MessageManager.h"

typedef void(^ReturnValueBlock)(id returnValue);

@interface BaseModel : NSObject

// 数据成功返回回调
@property (nonatomic, copy) ReturnValueBlock successBlock;
// 提示语回调
@property (nonatomic, copy) ReturnValueBlock messageInfo;
// 失败返回回调
@property (nonatomic, copy) ReturnValueBlock failureBlock;

- (void)setBlockWithReturnBlock:(ReturnValueBlock) successBlock
               WithMessageBlock:(ReturnValueBlock) messageInfo
               WithFailureBlock:(ReturnValueBlock) failureBlock;

+ (id)instanceModelWithDictionary:(NSDictionary *)dic;

@end
