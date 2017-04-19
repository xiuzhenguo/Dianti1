//
//  UITabBar+Badge.m
//  Huodi
//
//  Created by admin on 16/2/15.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "UITabBar+Badge.h"

@implementation UITabBar (Badge)
#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0
- (void)showBadgeOnItemIndex:(int)index badge:(int)badge{
    //移除之前的小红点
    [self removeBadgeOnItemIndex:index];
    
    //新建小红点
    UIView *badgeView = [[UIView alloc]init];
    badgeView.tag = 888 + index;
    badgeView.layer.cornerRadius = 9;//圆形
    badgeView.backgroundColor = UIColorFromRGB(0xe60012);//颜色：红色
    CGRect tabFrame = self.frame;
    
    
    //确定小红点的位置
    float percentX = (index +0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabFrame.size.width);
    CGFloat y = ceilf(0.05 * tabFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 18, 18);//圆形大小为10
    [self addSubview:badgeView];
    
    UILabel *badgeLabel = [[UILabel alloc] init];
    badgeLabel.frame = CGRectMake(0, 0, 18, 18);
    badgeLabel.textColor = [UIColor whiteColor];
    badgeLabel.text = [NSString stringWithFormat:@"%d",badge];
    badgeLabel.textAlignment = 1;
    badgeLabel.font = TEXTFONT(12);
    if (badge > 99) {
        badgeLabel.text = @"···";
        badgeLabel.font = TEXTFONT(10);
    }
    [badgeView addSubview:badgeLabel];
    
    
}

//隐藏小红点
- (void)hideBadgeOnItemIndex:(int)index{
    //移除小红点
    [self removeBadgeOnItemIndex:index];
}

//移除小红点
- (void)removeBadgeOnItemIndex:(int)index{
    //按照tag值进行移除
    for (UIView *subView in self.subviews) {
        if (subView.tag == 888+index) {
            [subView removeFromSuperview];
        }
    }
}

@end
