//
//  BaseModel.m
//  AliPayDemo
//
//  Created by James Hsu on 1/24/17.
//  Copyright © 2017 James Hsu. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (void)setBlockWithReturnBlock:(ReturnValueBlock) successBlock
               WithMessageBlock:(ReturnValueBlock) messageInfo
               WithFailureBlock:(ReturnValueBlock) failureBlock
{
    _successBlock = successBlock;
    _messageInfo  = messageInfo;
    _failureBlock = failureBlock;
}

/**
 * 这里返回空是为了让调用的时候才去实现
 */
+ (id)instanceModelWithDictionary:(NSDictionary *)dic
{
    return nil;
}

- (void)dealloc
{
    _successBlock = nil;
    _messageInfo  = nil;
    _failureBlock = nil;
}

@end
