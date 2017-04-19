//
//  PropertyAlarmDetailTableViewCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/6.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DividingLine.h"
@interface PropertyAlarmDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *key;
@property (weak, nonatomic) IBOutlet UILabel *value;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *valueWidth;
@property (nonatomic, copy) NSString *keyStr;
@property (nonatomic, copy) NSString *valueStr;
@property (nonatomic, copy) NSString *valueStr2;
@property (nonatomic, strong) DividingLine *line1;
@property (nonatomic, strong) DividingLine *line2;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;


@property (nonatomic) BOOL isClick;

@end
