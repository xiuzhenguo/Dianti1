//
//  PropertyAlarmDetailTableViewCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/6.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyAlarmDetailTableViewCell.h"

#import "UIView+baseAdditon.h"
@implementation PropertyAlarmDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _line1 = [[DividingLine alloc] init];
    [self.contentView addSubview:_line1];
    [_stateBtn setImage:[UIImage imageNamed:@"gaojing_shangla"] forState:UIControlStateSelected];
    _stateBtn.userInteractionEnabled = NO;
//    _stateBtn.alpha = YES;

}

- (void)setValueStr:(NSString *)valueStr
{
    float width1 = KWindowWidth - 35 - [self countTheStrLength:_keyStr] * 14;
    NSInteger hRow = [self countTheStrLength:valueStr] * 14 / width1;
    _valueWidth.constant = width1;
    _value.height = _value.height + hRow * 14;
    
    _line1.frame = CGRectMake(0, 48.5 + hRow * 14, KWindowWidth, 0.5);
    
}

- (void)setValueStr2:(NSString *)valueStr2
{
    float width1 = KWindowWidth - 45 - [self countTheStrLength:_keyStr] * 14;
    _valueWidth.constant = width1;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
    CGRect frame = [valueStr2 boundingRectWithSize:CGSizeMake(width1, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
    
    _line1.frame = CGRectMake(0, 34.5 + frame.size.height, KWindowWidth, 0.5);
    
    
    NSLog(@"%f",frame.size.height);
}

- (int)countTheStrLength:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
   
}

@end
