//
//  UIViewController+Extension.h
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Extension)
- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay;
@end
