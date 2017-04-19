//
//  UIView+Loading.h
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Loading)

- (void)showActivityWithImage:(UIImage *)image;
- (void)hidActivity;

- (void)showFailedViewReloadBlock:(void(^)())reloadBlock;
- (void)hidFailedView;

- (void)showEmptyDataViewWitlTitle:(NSString *)title actionTitle:(NSString *)actionTitle actionBlock:(void(^)())actionBlock;
- (void)hidEmptyDataView;
@end
