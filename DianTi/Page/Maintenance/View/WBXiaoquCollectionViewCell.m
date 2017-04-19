//
//  WBXiaoquCollectionViewCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/31.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBXiaoquCollectionViewCell.h"

@implementation WBXiaoquCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _photoImageV = [[UIImageView alloc] initWithFrame:CGRectMake(self.contentView.center.x - KWindowWidth * 0.125, 30, KWindowWidth * 0.25, KWindowWidth * 0.25)];
        
        [self.contentView addSubview:_photoImageV];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,  KWindowWidth * 0.25 + 40, self.contentView.frame.size.width, 28)];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_titleLabel];
        _titleLabel.text = @"11111";
        
        
        
    }
    
    return self;
}

- (void)setModel:(AreaModel *)model
{
    _photoImageV.image = [UIImage imageNamed:@"xiaoqu"];
    _titleLabel.text = model.areaName;
}

- (void)setEvevator:(EvevatorModel *)evevator
{
    switch ([evevator.evevatorState integerValue]) {
        case 1:
        {
            _photoImageV.image = [UIImage imageNamed:@"left_zhengchagn"];
            
        }
            break;
        case 2:
        {
            _photoImageV.image = [UIImage imageNamed:@"left_weishouli"];
        }
            break;
        case 3:
        {
            _photoImageV.image = [UIImage imageNamed:@"left_yishouli"];
        }
            break;
        case 4:
        {
            _photoImageV.image = [UIImage imageNamed:@"left_zhengzaiweixiu"];
        }
            break;
        case 5:
        {
            _photoImageV.image = [UIImage imageNamed:@"left_zhengzaiweixiu"];
        }
            break;
            
        default:
            break;
    }
    _titleLabel.text = [NSString stringWithFormat:@"%@",evevator.location];
}

@end
