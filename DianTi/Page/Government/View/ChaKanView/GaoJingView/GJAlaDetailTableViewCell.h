//
//  GJAlaDetailTableViewCell.h
//  DianTi
//
//  Created by 云彩 on 2017/4/12.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DividingLine.h"
#import "GJAlarmDetailModel.h"

@interface GJAlaDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) GJAlarmDetailModel *viewModel;
@property (nonatomic, assign) NSInteger *section;

@property (nonatomic, strong) DividingLine *line;

@property (nonatomic, strong) DividingLine *line2;

@property (nonatomic, strong) DividingLine *line3;

@property (nonatomic, strong) DividingLine *line4;

@property (nonatomic, strong) UILabel *alarmtypeLab;

@property (nonatomic, strong) UILabel *alarmdetailsLab;

@property (nonatomic, strong) UILabel *reportnameLab;

@property (nonatomic, strong) UILabel *reportphoneLab;

@end
