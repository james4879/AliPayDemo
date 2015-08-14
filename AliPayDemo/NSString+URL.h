//
//  NSString+URL.h
//  AliPay
//
//  Created by James Hsu on 8/7/15.
//  Copyright (c) 2015 James Hsu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URL)

/**
 *  URLEncode
 */
- (NSString *)URLEncodedString;

/**
 *  URLDecode
 */
-(NSString *)URLDecodedString;

@end
