//
//  UIViewController+Extension.m
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "UIViewController+Extension.h"

@implementation UIViewController (Extension)
- (void)performBlock:(void(^)())block afterDelay:(NSTimeInterval)delay {
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}
@end
