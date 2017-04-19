//
//  WBBaoyangCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/15.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecordModel.h"
#import "DividingLine.h"
@interface WBBaoyangCell : UITableViewCell

@property (nonatomic, strong) RecordModel *model;
@property (nonatomic, strong) RecordModel *jiluModel;
@property (weak, nonatomic) IBOutlet UILabel *idLbael;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldLabel;
@property (weak, nonatomic) IBOutlet UILabel *newstateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextTimeLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentWidth;
@property (nonatomic, strong) DividingLine *line1;


@end
