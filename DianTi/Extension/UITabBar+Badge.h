//
//  UITabBar+Badge.h
//  Huodi
//
//  Created by admin on 16/2/15.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (Badge)
- (void)showBadgeOnItemIndex:(int)index badge:(int)badge;   //显示小红点

- (void)hideBadgeOnItemIndex:(int)index; //隐藏小红点
@end
