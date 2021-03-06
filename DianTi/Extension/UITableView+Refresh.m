//
//  UITableView+Refresh.m
//  Huodi
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "UITableView+Refresh.h"
 
@implementation UITableView (Refresh)
- (void)addRefreshHeaderBlock:(MJRefreshComponentRefreshingBlock)blcok
{
    JHRefreshGifHeader *header = [JHRefreshGifHeader headerWithRefreshingBlock:blcok];
    [header.lastUpdatedTimeLabel setHidden:NO];
//    [header setImages:@[[UIImage imageNamed:@"arrow"],[UIImage imageNamed:@"arrow"]] duration:0.2 forState:MJRefreshStateRefreshing];
//    [header setImages:@[[UIImage imageNamed:@"arrow"]] forState:MJRefreshStateIdle];
    // 设置header
    self.mj_header = header;
    [header setTitle:@"正在刷新中..." forState:MJRefreshStateRefreshing];
    [header setTitle:@"下拉刷新界面" forState:MJRefreshStateIdle];
}
- (void)addRefreshFooterBlock:(MJRefreshComponentRefreshingBlock)blcok
{
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:blcok];
//    [footer setImages:@[[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""],[UIImage imageNamed:@""]] duration:0.2 forState:MJRefreshStateRefreshing];
//    [footer setImages:@[[UIImage imageNamed:@""]] forState:MJRefreshStateIdle];
    self.mj_footer = footer;
    [footer setTitle:@"正在加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
}
@end
