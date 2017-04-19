//
//  CKWBTypeTableViewCell.h
//  DianTi
//
//  Created by 云彩 on 2017/4/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WBTypeModel.h"
#import "DividingLine.h"

@interface CKWBTypeTableViewCell : UITableViewCell

@property (nonatomic, strong) WBTypeModel *viewModel;

@property (weak, nonatomic) IBOutlet UILabel *linneridLab;
@property (weak, nonatomic) IBOutlet UILabel *addtimeLab;
@property (weak, nonatomic) IBOutlet UILabel *lbuildNoLab;
@property (weak, nonatomic) IBOutlet UILabel *alarmtypeLab;
@property (weak, nonatomic) IBOutlet UILabel *orgstateLab;
@property (weak, nonatomic) IBOutlet UILabel *repairstateLab;
@property (weak, nonatomic) IBOutlet UILabel *snameLab;

@property (weak, nonatomic) IBOutlet UILabel *contentLab;


@end
