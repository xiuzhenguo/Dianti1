
//
//  CKDTDetailTableViewCell.m
//  DianTi
//
//  Created by 云彩 on 2017/4/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKDTDetailTableViewCell.h"

@implementation CKDTDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    self.leftLab = [[UILabel alloc] init];
    self.leftLab.font = [UIFont systemFontOfSize:14];
    self.leftLab.textColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:self.leftLab];
    
    self.rightLab = [[UILabel alloc] init];
    self.rightLab.font = [UIFont systemFontOfSize:14];
    self.rightLab.textColor = kTextColor;
    [self.contentView addSubview:self.rightLab];
    
    self.line = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line];
    
}

- (void)setRightArr:(NSMutableArray *)rightArr{
    _rightArr = rightArr;
    for (UIView *view in self.subviews) {
        view.frame = CGRectZero;
    }
    self.line.frame = CGRectMake(0, 49, KWindowWidth, 1);
    
    self.leftLab.text = self.leftArr[self.sction][self.row];
    CGRect left = Adaptive_Width(self.leftLab.text, self.leftLab.font);
    self.leftLab.frame = CGRectMake(15, 0, left.size.width, 49.5);
    
    self.rightLab.text = rightArr[self.sction][self.row];
    self.rightLab.frame = CGRectMake(CGRectGetMaxX(self.leftLab.frame), 0, KWindowWidth - CGRectGetMaxX(self.leftLab.frame) - 15, 49.5);
    
    if (self.sction == 1 && self.row == 0) {
        switch ([rightArr[1][0] integerValue]) {
            case 1:
            {
                self.rightLab.text = @"正常";
                self.rightLab.textColor = UIColorFromRGB(0x51d76a);
                
            }
                break;
            case 2:
            {
                self.rightLab.text = @"未处理";
                self.rightLab.textColor = UIColorFromRGB(0xfc3e39);
            }
                break;
            case 3:
            {
                self.rightLab.text = @"已处理";
                self.rightLab.textColor = UIColorFromRGB(0x00a0e9);
            }
                break;
            case 4:
            {
                self.rightLab.text = @"正在维修";
                self.rightLab.textColor = UIColorFromRGB(0xfd9527);
            }
                break;
            case 5:
            {
                self.rightLab.text = @"正在保养";
                self.rightLab.textColor = UIColorFromRGB(0x00561f);
            }
                break;
                
            default:
                break;
        }
    }else{
        self.rightLab.textColor = kTextColor;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
