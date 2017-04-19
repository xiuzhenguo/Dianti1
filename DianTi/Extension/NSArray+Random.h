//
//  NSArray+Random.h
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Random)
//随机获取一个数组中的对象
- (id)getObjectRandom;
//随机获取数组的一组数据 个数为count
- (NSArray *)getObjectsRandomWithCount:(NSUInteger)count;
@end
