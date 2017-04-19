//
//  NSArray+Random.m
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "NSArray+Random.h"

@implementation NSArray (Random)
- (id)getObjectRandom{
    if(self.count){
       return [[self getObjectsRandomWithCount:1] firstObject];
    }
    return nil;
}
- (NSArray *)getObjectsRandomWithCount:(NSUInteger)count
{
    if(!self.count || !count)
        return nil;
    count = count>=self.count?self.count:count;
    NSMutableArray *copySelf = [NSMutableArray arrayWithArray:self];
    NSMutableArray *array = [NSMutableArray array];
    for (NSInteger i=0, j = self.count; i<count; i++, j--) {
        NSInteger x = arc4random() %j;
        [array addObject:copySelf[x]];
        [copySelf removeObjectAtIndex:x];
    }
    return array;
}
@end
