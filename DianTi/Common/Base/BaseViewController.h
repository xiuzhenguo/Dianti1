//
//  BaseViewController.h
//  Huodi
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+baseAdditon.h"
#import "UIView+Loading.h"
#import "UIViewController+Extension.h"
@interface BaseViewController : UIViewController

- (void)showTabBar;
- (void)hideTabBar;
- (void)back:(id)sender;

@end
