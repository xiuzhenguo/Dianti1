//
//  ObjectUtil.m
//  Stanley
//
//  Created by 张洪海 on 15/12/25.
//  Copyright © 2015年 mohekeji. All rights reserved.
//

#import "ObjectUtil.h"
#import "NSObject+Property.h"
@implementation ObjectUtil

- (NSArray*)propertyKeys// 反射获取 类属性列表
{
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    NSMutableArray *keys = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        [keys addObject:propertyName];
        
        
    }
    free(properties);
    return keys;
}

- (BOOL)reflectDataFromOtherObject:(NSObject*)dataSource
{
    BOOL ret = NO;
    BOOL isKindOfNSDictionary = [dataSource isKindOfClass:[NSDictionary class]];
    for (NSString *key in [self propertyKeys]) {
        if (isKindOfNSDictionary) {
            ret = ([dataSource valueForKey:key]==nil)?NO:YES;
        }
        else
        {
            ret = [dataSource respondsToSelector:NSSelectorFromString(key)];
        }
        if (ret) {
            id propertyValue = [dataSource valueForKey:key];
            //该值不为NSNULL，并且也不为nil
            if (![propertyValue isKindOfClass:[NSNull class]] && propertyValue!=nil) {
                [self setValue:propertyValue forKey:key];
            }
            else
            {
                
            }
        }
    }
    return ret;
}

@end


