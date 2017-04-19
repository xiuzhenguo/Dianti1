//
//  DividingLine.m
//  Ningcheng
//
//  Created by 佘坦烨 on 16/11/1.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "DividingLine.h"

@implementation DividingLine

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

static DividingLine *line = nil;

- (instancetype)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kLineColor;
    }
    return self;
}



@end
