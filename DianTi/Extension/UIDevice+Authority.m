//
//  UIDevice+Authority.m
//  Huodi
//
//  Created by admin on 16/3/11.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import "UIDevice+Authority.h"

@implementation UIDevice (Authority)
+ (BOOL)isAllowedNotification {
     return  [[UIApplication sharedApplication] isRegisteredForRemoteNotifications];
}
@end
