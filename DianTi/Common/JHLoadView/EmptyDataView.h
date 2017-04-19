//
//  EmptyDataView.h
//  Huodi
//
//  Created by admin on 16/1/18.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EmptyDataView : UIView
@property (copy, nonatomic) void(^actionBlock)();
- (id)initWithFrame:(CGRect)frame title:(NSString *)title actionTitle:(NSString *)actionTitle;
@end
