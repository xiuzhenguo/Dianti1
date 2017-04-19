//
//  UIView+Loading.m
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "UIView+Loading.h"
#import "JHAnimationActivity.h"
#import "FailedloadView.h"
#import "EmptyDataView.h"

#define LoadingTag              10051
#define FailedTag               10052
#define EmptyDataViewTag        10053
@implementation UIView (Loading)
- (void)showActivityWithImage:(UIImage *)image
{
    [self hidActivity];
    JHAnimationActivity *activity = [[JHAnimationActivity alloc]initWithImage:image];
    activity.tag = LoadingTag;
    [activity showInView:self];
}
- (void)hidActivity
{
    JHAnimationActivity *activity = [self viewWithTag:LoadingTag];
    [activity dismiss];
    activity = nil;
}

- (void)showFailedViewReloadBlock:(void(^)())reloadBlock
{
    [self hidFailedView];
    FailedloadView *failedView = [[FailedloadView alloc]initWithFrame:self.bounds];
    [failedView setTag:FailedTag];
    [failedView setBackgroundColor:kBackgroundColor];
    [failedView setReloadBlock:reloadBlock];
    [self addSubview:failedView];
}
- (void)hidFailedView{
    FailedloadView *failedView = [self viewWithTag:FailedTag];
    [failedView removeFromSuperview];
}

- (void)showEmptyDataViewWitlTitle:(NSString *)title actionTitle:(NSString *)actionTitle actionBlock:(void(^)())actionBlock
{
    
    EmptyDataView *emptyView = [[EmptyDataView alloc]initWithFrame:self.bounds title:title actionTitle:actionTitle];
    [emptyView setBackgroundColor:kBackgroundColor];
    [emptyView setTag:EmptyDataViewTag];
    [emptyView setActionBlock:actionBlock];
    [self addSubview:emptyView];
}

- (void)hidEmptyDataView
{
    EmptyDataView *emptyView = [self viewWithTag:EmptyDataViewTag];
    [emptyView removeFromSuperview];
}
@end
