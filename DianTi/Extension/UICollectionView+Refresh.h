//
//  UICollectionView+Refresh.h
//  DianTi
//
//  Created by 佘坦烨 on 17/1/17.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>
#import <MJRefreshAutoGifFooter.h>
#import "JHRefreshGifHeader.h"
@interface UICollectionView (Refresh)
- (void)addRefreshHeaderBlock:(MJRefreshComponentRefreshingBlock)block;
- (void)addRefreshFooterBlock:(MJRefreshComponentRefreshingBlock)blcok;
@end
