//
//  WBLeftBaoyangCell.h
//  DianTi
//
//  Created by 佘坦烨 on 17/1/19.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DividingLine.h"
#import "RecordModel.h"
@interface WBLeftBaoyangCell : UITableViewCell

@property (nonatomic, strong) RecordModel *model;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *oldStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *newstateLabel;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nextDataWidth;
@property (nonatomic, strong) DividingLine *line1;

@end
