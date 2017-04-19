//
//  VerticalAlignmentLabel.h
//  GoftApp
//
//  Created by admin on 15/8/30.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;

@interface VerticalAlignmentLabel : UILabel
{

    VerticalAlignment _verticalAlignment;
}

@property (nonatomic) VerticalAlignment verticalAlignment;

@end

