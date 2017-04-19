//
//  WBPeopleListCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/14.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReporterModel.h"
@interface WBPeopleListCell : UITableViewCell

@property (nonatomic, strong) ReporterModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *stateIV;
@property (weak, nonatomic) IBOutlet UILabel *peopleIdLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;

@end
