//
//  FailedloadView.h
//  ShakeOrder
//
//  Created by aaaa on 14-7-25.
//  Copyright (c) 2014年 hjc. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FailedloadView : UIView
{
}
@property (copy, nonatomic) void(^reloadBlock)();

- (id)initWithFrame:(CGRect)frame;

@end
