//
//  JHAnimationActivity.h
//  Huodi
//
//  Created by admin on 16/1/14.
//  Copyright © 2016年 mohekeji. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHAnimationActivity : UIView
{
    UIImage *_image;
}
- (instancetype)initWithImage:(UIImage *)image;
- (void)showInView:(UIView *)view;
- (void)dismiss;

@end
