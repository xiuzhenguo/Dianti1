//
//  PropertyBaoxiuCell.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/6.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyBaoxiuCell.h"
#import "UIImage+Color.h"
#import "DividingLine.h"

@implementation PropertyBaoxiuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 60.5, KWindowWidth, 0.5)];
    [self.contentView addSubview:line1];
    
}

- (void)setModel:(EvevatorModel *)model
{
    _idLabel.text = [NSString stringWithFormat:@"%@",model.innerid];
    _locationLabel.text = [NSString stringWithFormat:@"%@",model.location];
    
    _baoxiuBtn.layer.cornerRadius = 5;
    _baoxiuBtn.layer.masksToBounds = YES;
    _baoxiuBtn.layer.borderWidth = 1;
    _baoxiuBtn.layer.borderColor = kMainColor.CGColor;
    
    [_baoxiuBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [_baoxiuBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [_baoxiuBtn setBackgroundImage:[UIImage createImageWithColor:kMainColor] forState:UIControlStateHighlighted];
    [_baoxiuBtn setBackgroundImage:[UIImage createImageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
}

- (IBAction)baoxiuClick:(id)sender {
    NSLog(@"111111111");
}

- (NSString *)buqiName:(NSString *)name
{
    if (name.length >= 5 || name == nil)
    {
        return name;
    }
    else
    {
        NSMutableString *str = [NSMutableString string];
        for (int i = 0; i < 5 - name.length; i++) {
            [str appendString:@"0"];
        }
        [str appendString:name];
        return str;
    }
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
