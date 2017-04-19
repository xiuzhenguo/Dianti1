//
//  UIImage+Color.m
//  Spider
//
//  Created by Zhigang Yang on 16/5/24.
//  Copyright © 2016年 Leaping Spider. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)
+(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
