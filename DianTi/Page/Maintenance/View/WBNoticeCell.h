//
//  WBNoticeCell.h
//  DianTi
//
//  Created by 佘坦烨 on 16/12/16.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MGSwipeTableCell.h>
#import "NoticeModel.h"
@interface WBNoticeCell : MGSwipeTableCell

@property (nonatomic, strong) NoticeModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;




@end
