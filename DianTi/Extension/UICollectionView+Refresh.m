//
//  UICollectionView+Refresh.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "UICollectionView+Refresh.h"

@implementation UICollectionView (Refresh)
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
