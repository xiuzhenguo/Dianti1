//
//  WBContentCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/15.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBContentCell.h"
#import "DividingLine.h"
@implementation WBContentCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _contentlabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  0, self.contentView.frame.size.width - 1, self.contentView.frame.size.height)];
        _contentlabel.textAlignment = NSTextAlignmentCenter;
        _contentlabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_contentlabel];
        
        
        DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.contentView.frame.size.height - 0.5, self.contentView.frame.size.width, 0.5)];
        DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0,  0, 1, self.contentView.frame.size.height)];
        
        [self.contentView addSubview:line1];
        [self.contentView addSubview:line2];
        
    }
    
    return self;
}

- (void)setModel:(AreaModel *)model
{
    self.contentlabel.text = [NSString stringWithFormat:@"%@",model.areaName];
    if ([model.state integerValue] == 0) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.contentlabel.textColor = kMainColor;
    }
    else
    {
        self.contentView.backgroundColor = kMainColor;
        self.contentlabel.textColor = [UIColor whiteColor];
    }
    
}

@end
