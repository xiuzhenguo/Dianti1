//
//  UITableView+Refresh.h
//  Huodi
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import <MJRefreshAutoGifFooter.h>
#import "JHRefreshGifHeader.h"

@interface UITableView (Refresh)
- (void)addRefreshHeaderBlock:(MJRefreshComponentRefreshingBlock)block;
- (void)addRefreshFooterBlock:(MJRefreshComponentRefreshingBlock)blcok;
@end
