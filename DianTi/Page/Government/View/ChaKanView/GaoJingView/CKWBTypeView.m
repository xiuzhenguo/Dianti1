//
//  CKWBTypeView.m
//  DianTi
//
//  Created by 云彩 on 2017/4/14.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKWBTypeView.h"
#import "CKWBTypeTableViewCell.h"
#import "WBTypeModel.h"
#import "CKWXTypeTableViewCell.h"

@interface CKWBTypeView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *typeStr;

@end

@implementation CKWBTypeView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpHeadViewUI];
    }
    return self;
}

-(void) setUpHeadViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight - 64 - 120)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"CKWBTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 202;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CKWBTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    WBTypeModel *model = self.dataArray[indexPath.row];
    cell.linneridLab.text = [NSString stringWithFormat:@"电梯编号：%@",model.linnerid];
    cell.addtimeLab.text = model.addtime;
    cell.lbuildNoLab.text = model.lbuildno;
    cell.alarmtypeLab.text = model.alarmtype;
    cell.snameLab.text = model.sname;
    cell.contentLab.text = model.content;
    cell.contentLab.numberOfLines = 0;
    
    switch ([model.orgstate integerValue]) {
        case 1:
        {
            cell.orgstateLab.text = @"正常";
            cell.orgstateLab.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            cell.orgstateLab.text = @"未处理";
            cell.orgstateLab.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            cell.orgstateLab.text = @"已处理";
            cell.orgstateLab.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            cell.orgstateLab.text = @"正在维修";
            cell.orgstateLab.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            cell.orgstateLab.text = @"正在保养";
            cell.orgstateLab.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
    
    switch ([model.repairstate integerValue]) {
        case 1:
        {
            cell.repairstateLab.text = @"正常";
            cell.repairstateLab.textColor = UIColorFromRGB(0x51d76a);
            
        }
            break;
        case 2:
        {
            cell.repairstateLab.text = @"未处理";
            cell.repairstateLab.textColor = UIColorFromRGB(0xfc3e39);
        }
            break;
        case 3:
        {
            cell.repairstateLab.text = @"已处理";
            cell.repairstateLab.textColor = UIColorFromRGB(0x00a0e9);
        }
            break;
        case 4:
        {
            cell.repairstateLab.text = @"正在维修";
            cell.repairstateLab.textColor = UIColorFromRGB(0xfd9527);
        }
            break;
        case 5:
        {
            cell.repairstateLab.text = @"正在保养";
            cell.repairstateLab.textColor = UIColorFromRGB(0x00561f);
        }
            break;
            
        default:
            break;
    }
    
    //    tableView.rowHeight = CGRectGetMaxY(cell.contentLab.frame)+20;
    
    return cell;
   
}


@end
