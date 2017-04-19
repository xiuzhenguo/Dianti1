//
//  JHRefreshGifHeader.h
//  Huodi
//
//  Created by admin on 16/1/27.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <MJRefreshStateHeader.h>

@interface JHRefreshGifHeader : MJRefreshStateHeader
/** 设置state状态下的动画图片images 动画持续时间duration*/
- (void)setImages:(NSArray *)images duration:(NSTimeInterval)duration forState:(MJRefreshState)state;
- (void)setImages:(NSArray *)images forState:(MJRefreshState)state;
@end
