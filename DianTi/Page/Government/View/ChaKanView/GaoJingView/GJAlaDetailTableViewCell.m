//
//  GJAlaDetailTableViewCell.m
//  DianTi
//
//  Created by 云彩 on 2017/4/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "GJAlaDetailTableViewCell.h"

@implementation GJAlaDetailTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUpTableViewCellUI];
    }
    return self;
}

-(void) setUpTableViewCellUI {
    self.alarmtypeLab = [[UILabel alloc] init];
    self.alarmtypeLab.font = [UIFont systemFontOfSize:14];
    self.alarmtypeLab.textColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:self.alarmtypeLab];
    
    self.alarmdetailsLab = [[UILabel alloc] init];
    self.alarmdetailsLab.font = [UIFont systemFontOfSize:14];
    self.alarmdetailsLab.numberOfLines = 0;
    self.alarmdetailsLab.textColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:self.alarmdetailsLab];
    
    self.reportnameLab = [[UILabel alloc] init];
    self.reportnameLab.font = [UIFont systemFontOfSize:14];
    self.reportnameLab.textColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:self.reportnameLab];
    
    self.reportphoneLab = [[UILabel alloc] init];
    self.reportphoneLab.font = [UIFont systemFontOfSize:14];
    self.reportphoneLab.textColor = UIColorFromRGB(0x666666);
    [self.contentView addSubview:self.reportphoneLab];
    
    self.line = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line];
    
    self.line2 = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line2];
    
    self.line3 = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line3];
    
    self.line4 = [[DividingLine alloc] init];
    [self.contentView addSubview:self.line4];
}

- (void)setViewModel:(GJAlarmDetailModel *)viewModel{
    _viewModel = viewModel;
    for (UIView *view in self.subviews) {
        view.frame = CGRectZero;
    }
    self.line.frame = CGRectMake(0, 49.5, KWindowWidth, 0.5);
    self.line2.frame = CGRectMake(0, 49.5+50, KWindowWidth, 0.5);
    self.line3.frame = CGRectMake(0, 49.5+100, KWindowWidth, 0.5);
    self.line4.frame = CGRectMake(0, 49.5+150, KWindowWidth, 0.5);
    self.alarmtypeLab.frame = CGRectMake(35, 0, KWindowWidth - 50, 49.5);

    NSString  *strStaus = @"告警故障类型：";
    NSString *strr = [NSString stringWithFormat:@"%@%@",strStaus,viewModel.alarmtype];
    NSMutableAttributedString *attrDescribe = [[NSMutableAttributedString alloc] initWithString:strr];
    [attrDescribe addAttribute:NSForegroundColorAttributeName
     
                            value:kTextColor
     
                            range:[strr rangeOfString:viewModel.alarmtype]];
    self.alarmtypeLab.attributedText = attrDescribe;
    
    self.alarmdetailsLab.frame = CGRectMake(35,50, KWindowWidth - 50, 49.5);
    NSString  *alaStaus = @"告警故障详情：";
    NSString *ala = [NSString stringWithFormat:@"%@%@",alaStaus,viewModel.alarmdetails];
    NSMutableAttributedString *attrDescribeStr = [[NSMutableAttributedString alloc] initWithString:ala];
    [attrDescribeStr addAttribute:NSForegroundColorAttributeName
     
                            value:kTextColor
     
                            range:[ala rangeOfString:viewModel.alarmdetails]];
    self.alarmdetailsLab.attributedText = attrDescribeStr;
    
    self.reportnameLab.frame = CGRectMake(35, 100, KWindowWidth - 50, 49.5);

    NSString  *repStaus = @"报修者名称：";
    NSString *rep = [NSString stringWithFormat:@"%@%@",repStaus,viewModel.reportname];
    NSMutableAttributedString *attrDescribes = [[NSMutableAttributedString alloc] initWithString:rep];
    [attrDescribes addAttribute:NSForegroundColorAttributeName
     
                         value:kTextColor
     
                         range:[rep rangeOfString:viewModel.reportname]];
    self.reportnameLab.attributedText = attrDescribes;
    
    self.reportphoneLab.frame = CGRectMake(35, 150, KWindowWidth - 50, 49.5);
    NSString  *phoStaus = @"报修者电话：";
    NSString *pho = [NSString stringWithFormat:@"%@%@",phoStaus,viewModel.reportphone];
    NSMutableAttributedString *attrDescribest = [[NSMutableAttributedString alloc] initWithString:pho];
    [attrDescribest addAttribute:NSForegroundColorAttributeName
     
                          value:kTextColor
     
                          range:[pho rangeOfString:viewModel.reportphone]];
    self.reportphoneLab.attributedText = attrDescribest;
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
