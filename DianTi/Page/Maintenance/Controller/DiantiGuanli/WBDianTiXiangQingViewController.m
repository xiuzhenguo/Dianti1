//
//  WBDianTiXiangQingViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/16.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WBDianTiXiangQingViewController.h"
#import "WBDianTiLiShiJiLuViewController.h"
#import "WBDianTiGaoJingViewController.h"

#import "PropertyAlarmDetailTableViewCell.h"
#import "WBLeftDetailCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"

#import "FaultModel.h"
#import "PersonInformation.h"
@interface WBDianTiXiangQingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *itemArray;
    NSMutableArray *sectionArray1;
    NSMutableArray *sectionArray2;
    NSMutableArray *sectionArray3;
    NSMutableArray *sectionArray4;
    NSMutableArray *shebeiArray;
    NSMutableArray *baoyangArray;
    NSMutableArray *weixiuArray;
    
    
    NSArray *repairlist;
    NSArray *maintainlist;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;

@property (nonatomic) BOOL shebeiClicked;
@property (nonatomic) BOOL weixiuClicked;
@property (nonatomic) BOOL baoyangClicked;


@end

@implementation WBDianTiXiangQingViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
    
}

- (void)setupSubview
{
    if ([[PersonInformation sharedPersonInformation].user_type integerValue] == 3 && [_evevator.evevatorState integerValue] == 1) {
        _bottomDistance.constant = 50;
    }
    else
    {
        _bottomDistance.constant = 0;
    }
}
- (void)loadData
{
    self.shebeiClicked = NO;
    self.weixiuClicked = NO;
    self.baoyangClicked = NO;
    
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getEvevatorDetailWithLID:_evevator.evevatorID pageIndex:@"1" pageSize:@"10" success:^(id responseObject) {
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSDictionary *model = responseObject[@"model"];
        NSDictionary *wbcompany = model[@"wbcompany"];
        NSDictionary *wycompany = model[@"wycompany"];
        repairlist = model[@"repairlist"];
        if (repairlist.count > 0) {
            NSDictionary *repair = repairlist[0];
            weixiuArray = [NSMutableArray arrayWithObjects:@{@"left":@"维修时间：",@"right":repair[@"addtime"]},
  @{@"left":@"维修前状态：",@"right":repair[@"orgstate"]},
  @{@"left":@"维修后状态：",@"right":repair[@"repairstate"]},
  @{@"left":@"维修人：",@"right":repair[@"sname"]},
  @{@"left":@"维修备注：",@"right":repair[@"content"]},
  @{@"left":@"历史记录：",@"right":@""}, nil];
        }
        
        maintainlist = model[@"maintainlist"];
        if (maintainlist.count > 0) {
            NSDictionary *maintain = maintainlist[0];
            baoyangArray = [NSMutableArray arrayWithObjects:@{@"left":@"保养时间：",@"right":maintain[@"addtime"]},
  @{@"left":@"保养前状态：",@"right":maintain[@"orgstate"]},
  @{@"left":@"保养后状态：",@"right":maintain[@"maintainstate"]},
  @{@"left":@"维修人：",@"right":maintain[@"sname"]},
  @{@"left":@"下次保养时间：",@"right":maintain[@"nextcaredate"]},
  @{@"left":@"历史记录：",@"right":@""}, nil];
        }
        
        sectionArray1 = [NSMutableArray arrayWithObjects:@{@"left":@"内部编号：",@"right":model[@"innerid"]},
  @{@"left":@"电梯状态：",@"right":model[@"state"]},
  @{@"left":@"电梯位置：",@"right":model[@"buildno"]},
  @{@"left":@"维保单位：",@"right":wbcompany[@"wbname"]},
  @{@"left":@"注册代码：",@"right":model[@"regcode"]},
  @{@"left":@"下次保养日期：",@"right":model[@"nextcaredate"]}, nil];
        sectionArray2 = [NSMutableArray arrayWithObjects:@{@"left":@"设备资料",@"right":@""}, nil];
        sectionArray3 = [NSMutableArray arrayWithObjects:@{@"left":@"维修记录",@"right":@""}, nil];
        sectionArray4 = [NSMutableArray arrayWithObjects:@{@"left":@"保养记录",@"right":@""}, nil];
        if ([self.typestr isEqualToString:@"wycompany"]) {
            shebeiArray = [NSMutableArray arrayWithObjects:@{@"left":@"维保单位：",@"right":wbcompany[@"wbname"]},
                           @{@"left":@"法人代表：",@"right":wbcompany[@"legalname"]},
                           @{@"left":@"联系电话：",@"right":wbcompany[@"phone"]},
                           @{@"left":@"维保应急电话：",@"right":wbcompany[@"hotphone"]},
                           @{@"left":@"维保公司地址：",@"right":wbcompany[@"address"]},
                           @{@"left":@"维保资质：",@"right":wbcompany[@"wbright"]},
                           @{@"left":@"维保资质有效期：",@"right":wbcompany[@"wbrightdate"]},
                           @{@"left":@"额定载重（kg）：",@"right":model[@"ratedweight"]},
                           @{@"left":@"额定速递（m/s）：",@"right":model[@"ratedspeed"]},
                           @{@"left":@"层/站/门：",@"right":model[@"floorstationdoor"]},
                           @{@"left":@"控制方式：",@"right":model[@"controlfunc"]},
                           @{@"left":@"产品型号：",@"right":model[@"productmodel"]},
                           @{@"left":@"产品编号：",@"right":model[@"productid"]},
                           @{@"left":@"制造单位：",@"right":model[@"madeby"]},
                           @{@"left":@"制造日期：",@"right":model[@"madedate"]},
                           @{@"left":@"安装单位：",@"right":model[@"installby"]},
                           @{@"left":@"安装日期：",@"right":model[@"installdate"]}, nil];

        }else{
            
            shebeiArray = [NSMutableArray arrayWithObjects:@{@"left":@"物业单位：",@"right":wycompany[@"wyname"]},
                           @{@"left":@"法人代表：",@"right":wycompany[@"legalname"]},
                           @{@"left":@"联系电话：",@"right":wycompany[@"phone"]},
                           @{@"left":@"物业公司地址：",@"right":wycompany[@"address"]},
                           @{@"left":@"使用登记证编号：",@"right":wycompany[@"regNo"]},
                           @{@"left":@"检验报告编号：",@"right":wycompany[@"reportNo"]},
                           @{@"left":@"额定载重（kg）：",@"right":model[@"ratedweight"]},
                           @{@"left":@"额定速递（m/s）：",@"right":model[@"ratedspeed"]},
                           @{@"left":@"层/站/门：",@"right":model[@"floorstationdoor"]},
                           @{@"left":@"控制方式：",@"right":model[@"controlfunc"]},
                           @{@"left":@"产品型号：",@"right":model[@"productmodel"]},
                           @{@"left":@"产品编号：",@"right":model[@"productid"]},
                           @{@"left":@"制造单位：",@"right":model[@"madeby"]},
                           @{@"left":@"制造日期：",@"right":model[@"madedate"]},
                           @{@"left":@"安装单位：",@"right":model[@"installby"]},
                           @{@"left":@"安装日期：",@"right":model[@"installdate"]}, nil];
        }
        
        itemArray = [NSMutableArray arrayWithObjects:sectionArray1,sectionArray2,sectionArray3,sectionArray4, nil];
        
        
        [weakSelf.tableview reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadData];
            }];
        }
    }];
    
}

#pragma mark - tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return itemArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = itemArray[section];
    return  array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.section == 0) {
        PropertyAlarmDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            cell.stateBtn.alpha = 0;
            
        }
        else
        {
            cell.stateBtn.alpha = 1;
        }
        if (indexPath.section == 1) {
            cell.stateBtn.selected = self.shebeiClicked;
            if (self.shebeiClicked) {
                cell.line1.backgroundColor = [UIColor whiteColor];
            }
            else
            {
                cell.line1.backgroundColor = kLineColor;
            }
            
        }
        if (indexPath.section == 2) {
            cell.stateBtn.selected = self.weixiuClicked;
            if (self.weixiuClicked) {
                cell.line1.backgroundColor = [UIColor whiteColor];
            }
            else
            {
                cell.line1.backgroundColor = kLineColor;
            }
        }
        if (indexPath.section == 3) {
            cell.stateBtn.selected = self.baoyangClicked;
            if (self.baoyangClicked) {
                cell.line1.backgroundColor = [UIColor whiteColor];
            }
            else
            {
                cell.line1.backgroundColor = kLineColor;
            }
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *array1 = itemArray[indexPath.section];
        NSDictionary *tempDic = array1[indexPath.row];
        cell.key.text = [NSString stringWithFormat:@"%@",tempDic[@"left"]];
        cell.keyStr = [NSString stringWithFormat:@"%@",tempDic[@"left"]];
        cell.value.text = [NSString stringWithFormat:@"%@",tempDic[@"right"]];
        cell.valueStr = [NSString stringWithFormat:@"%@",tempDic[@"right"]];
        
        if (indexPath.row == 0) {
            DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
            [cell.contentView addSubview:line1];
        }
        else
        {
            UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
            line1.backgroundColor = [UIColor whiteColor];
            [cell.contentView addSubview:line1];
        }
        if (indexPath.section == 0 && indexPath.row == 1) {
            switch ([tempDic[@"right"] integerValue]) {
                case 1:
                {
                    cell.value.text = @"正常";
                    cell.value.textColor = UIColorFromRGB(0x51d76a);
                    
                }
                    break;
                case 2:
                {
                    cell.value.text = @"未处理";
                    cell.value.textColor = UIColorFromRGB(0xfc3e39);
                }
                    break;
                case 3:
                {
                    cell.value.text = @"已处理";
                    cell.value.textColor = UIColorFromRGB(0x00a0e9);
                }
                    break;
                case 4:
                {
                    cell.value.text = @"正在维修";
                    cell.value.textColor = UIColorFromRGB(0xfd9527);
                }
                    break;
                case 5:
                {
                    cell.value.text = @"正在保养";
                    cell.value.textColor = UIColorFromRGB(0x00561f);
                }
                    break;
                    
                default:
                    break;
            }
        }
        else
        {
            cell.value.textColor = UIColorFromRGB(0x333333);
        }
        
        
        return cell;
    }
    else if (indexPath.row == 6 && indexPath.section > 1)
    {
        WBLeftDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.section == 2) {
            [cell.historyButton removeTarget:self action:@selector(baoyangClick) forControlEvents:UIControlEventTouchUpInside];
            
            [cell.historyButton addTarget:self action:@selector(weixiuClick) forControlEvents:UIControlEventTouchUpInside];
        }
        else
        {
            [cell.historyButton removeTarget:self action:@selector(weixiuClick) forControlEvents:UIControlEventTouchUpInside];
            [cell.historyButton addTarget:self action:@selector(baoyangClick) forControlEvents:UIControlEventTouchUpInside];
        }
        return cell;

    }
    else{
        PropertyAlarmDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.stateBtn.alpha = 0;
        NSArray *array1 = itemArray[indexPath.section];
        NSDictionary *tempDic = array1[indexPath.row];
        cell.key.text = [NSString stringWithFormat:@"%@",tempDic[@"left"]];
        cell.keyStr = [NSString stringWithFormat:@"%@",tempDic[@"left"]];
        cell.value.text = [NSString stringWithFormat:@"%@",tempDic[@"right"]];
        cell.valueStr2 = [NSString stringWithFormat:@"%@",tempDic[@"right"]];
        if ((indexPath.row == 3 || indexPath.row == 2) && indexPath.section > 1 ) {
            switch ([tempDic[@"right"] integerValue]) {
                case 1:
                {
                    cell.value.text = @"正常";
                    cell.value.textColor = UIColorFromRGB(0x51d76a);
                    
                }
                    break;
                case 2:
                {
                    cell.value.text = @"未处理";
                    cell.value.textColor = UIColorFromRGB(0xfc3e39);
                }
                    break;
                case 3:
                {
                    cell.value.text = @"已处理";
                    cell.value.textColor = UIColorFromRGB(0x00a0e9);
                }
                    break;
                case 4:
                {
                    cell.value.text = @"正在维修";
                    cell.value.textColor = UIColorFromRGB(0xfd9527);
                }
                    break;
                case 5:
                {
                    cell.value.text = @"正在保养";
                    cell.value.textColor = UIColorFromRGB(0x00561f);
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 48.5, KWindowWidth, 0.5)];
        line1.backgroundColor = [UIColor whiteColor];
        [cell.contentView addSubview:line1];
        cell.value.textColor = UIColorFromRGB(0x333333);
        
        return cell;
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array1 = itemArray[indexPath.section];
    NSDictionary *tempDic = array1[indexPath.row];
    NSString *left = [NSString stringWithFormat:@"%@",tempDic[@"left"]];
    NSString *right = [NSString stringWithFormat:@"%@",tempDic[@"right"]];
    if (indexPath.section == 0 || indexPath.row == 0) {
        float width1 = KWindowWidth - 35 - [self countTheStrLength:left] * 14;
        NSInteger hRow = [self countTheStrLength:right] * 14 / width1;
       
        return 49 + hRow * 14;
    }
    else
    {
        float width1 = KWindowWidth - 45 - [self countTheStrLength:left] * 14 ;
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14], NSFontAttributeName, nil];
        CGRect frame = [right boundingRectWithSize:CGSizeMake(width1, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil];
        return 35 + frame.size.height;
    }
    
    return 55;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section != 1) {
        return 0.01;
    }
    return 20;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 20)];
    view.backgroundColor = self.view.backgroundColor;
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:itemArray[indexPath.section]];
        switch (indexPath.section) {
            case 1:
            {
                self.shebeiClicked = !self.shebeiClicked;
                if (self.shebeiClicked) {
                    [tempArray addObjectsFromArray:shebeiArray];
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                    [itemArray replaceObjectAtIndex:1 withObject:tempArray];
                    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                }
                else
                {
                    [tempArray removeObjectsInRange:NSMakeRange(1, tempArray.count -1)];
                    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:1];
                    [itemArray replaceObjectAtIndex:1 withObject:tempArray];
                    [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                }
            }
                break;
            case 2:
            {
                if (weixiuArray.count > 0) {
                    self.weixiuClicked = !self.weixiuClicked;
                    if (self.weixiuClicked) {
                        [tempArray addObjectsFromArray:weixiuArray];
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                        [itemArray replaceObjectAtIndex:2 withObject:tempArray];
                        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    else
                    {
                        [tempArray removeObjectsInRange:NSMakeRange(1, tempArray.count -1)];
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:2];
                        [itemArray replaceObjectAtIndex:2 withObject:tempArray];
                        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    }

                }
            }
                break;
            case 3:
            {
                if (baoyangArray.count > 0) {
                    self.baoyangClicked = !self.baoyangClicked;
                    if (self.baoyangClicked) {
                        [tempArray addObjectsFromArray:baoyangArray];
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                        [itemArray replaceObjectAtIndex:3 withObject:tempArray];
                        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                    else
                    {
                        [tempArray removeObjectsInRange:NSMakeRange(1, tempArray.count -1)];
                        NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:3];
                        [itemArray replaceObjectAtIndex:3 withObject:tempArray];
                        [self.tableview reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
                    }
                }
                
            }
                break;
                
            default:
                break;
        }
    }
    
}
#pragma mark - 计算字节
- (int)countTheStrLength:(NSString*)strtemp {
    int strlength = 0;
    char* p = (char*)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i=0 ; i<[strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding] ;i++) {
        if (*p) {
            p++;
            strlength++;
        }
        else {
            p++;
        }
    }
    return (strlength+1)/2;
}

#pragma mark -
- (void)weixiuClick
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    WBDianTiLiShiJiLuViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WBDianTiLiShiJiLu"];
    vc.sender = @"weixiu";
    vc.lid = _evevator.evevatorID;

    [self.navigationController pushViewController:vc animated:YES];
}

- (void)baoyangClick
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    WBDianTiLiShiJiLuViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WBDianTiLiShiJiLu"];
    vc.sender = @"baoyang";
    vc.lid = _evevator.evevatorID;

    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)gaojingClick:(id)sender {

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    WBDianTiGaoJingViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WBDianTiGaoJing"];
    vc.lid = _evevator.evevatorID;
    vc.location = _evevator.location;
    vc.state = _evevator.evevatorState;
    
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
