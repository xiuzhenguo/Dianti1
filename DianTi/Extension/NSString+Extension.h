//
//  NSString+Extension.h
//  ShakeOrder
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 hjc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)stringByMD5Encoding;


//检查手机号
- (BOOL)checkPhoneNumInput;
//检查密码
- (BOOL)checKPasswordInput;
//检查用户名
- (BOOL)checKUserName;
- (BOOL)checkString;
+(BOOL)isContainsEmoji:(NSString *)string;

@end
