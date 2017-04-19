
//
//  PropertyAlarmDetailsViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/6.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyAlarmDetailsViewController.h"
#import "PropertyManager.h"
#import "PropertyAlarmDetailTableViewCell.h"
#import "DividingLine.h"
#import "UIImage+Color.h"
#import "PropertyBaoxiuDetailViewController.h"
#import "EvevatorModel.h"
@interface PropertyAlarmDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *keyArray;
    NSMutableArray *valueArray;
    NSString *wuyeName;
    NSString *yezhuName;
    NSString *alarmId;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIButton *zhuijiaBtn;
@property (nonatomic, strong) PropertyBaoxiuDetailViewController *propertyVC;

@end

@implementation PropertyAlarmDetailsViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"电梯告警详情页";
    
    [self setupView];
    

}

- (void)setupView
{
    [self.zhuijiaBtn setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xffce54)] forState:UIControlStateNormal];
    [self.zhuijiaBtn setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xf8c136)] forState:UIControlStateHighlighted];
//    self.tableview.allowsSelection = NO;
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.backgroundColor = [UIColor clearColor];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [PropertyManager getAlarmDetailsWithLid:_lid success:^(id responseObject) {
        [weakSelf.view hidFailedView];
        [weakSelf.view hidFailedView];
        valueArray = [NSMutableArray arrayWithArray:responseObject];
        alarmId = valueArray[4];
        [valueArray removeLastObject];
        keyArray = [NSMutableArray arrayWithArray:@[@[@"电梯编号：",@"电梯位置：",@"电梯电梯状态：",@"故障类型：",@"故障详情："],@[@"报修者名称：",@"报修者电话："],@[@"维保公司名称：",@"维保公司电话：",@"告警时间："],@[@"报修总数:",@"追加报修人名称:",@"追加报修物业名称:"]]];
        NSMutableArray *temparray = [NSMutableArray arrayWithArray:valueArray[3]];
        wuyeName = temparray[2];
        yezhuName = temparray[1];
        [temparray replaceObjectAtIndex:1 withObject:@""];
        [temparray replaceObjectAtIndex:2 withObject:@""];
        [valueArray replaceObjectAtIndex:3 withObject:temparray];
        
        [weakSelf.tableview reloadData];
        [weakSelf.view hideHubWithActivity];
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
    return keyArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = keyArray[section];
    return  array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyAlarmDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.stateBtn.alpha = 0;
    if (indexPath.section == 3 && indexPath.row > 0){
        
        NSArray *array1 = keyArray[indexPath.section];
        NSString *str1 = array1[2];
        if (array1.count == 3) {
            cell.stateBtn.alpha = 1;
        }
        else if (array1.count == 4)
        {
            if ([str1 isEqualToString:@"追加报修物业名称:"]) {
                if (indexPath.row < 3) {
                    cell.stateBtn.alpha = 1;
                }
            }
            else
            {
                if (indexPath.row != 2) {
                    cell.stateBtn.alpha = 1;
                }
            }
        }
        else
        {
            if (indexPath.row == 1 || indexPath.row == 3) {
                cell.stateBtn.alpha = 1;
            }
        }
        
    }

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *array1 = keyArray[indexPath.section];
    cell.keyStr = [NSString stringWithFormat:@"%@",array1[indexPath.row]];
    cell.key.text = [NSString stringWithFormat:@"%@",array1[indexPath.row]];
    
    NSArray *array2 = valueArray[indexPath.section];
    
    cell.valueStr = [NSString stringWithFormat:@"%@",array2[indexPath.row]];
    cell.value.text = [NSString stringWithFormat:@"%@",array2[indexPath.row]];
    
    
//    if(indexPath.row == 3 && indexPath.section == 0)
//    {
//        cell.valueStr = cell.value.text;
//        
//    }
    
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
    if (indexPath.section == 0 && indexPath.row == 2) {
        switch ([array2[indexPath.row] integerValue]) {
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
        cell.value.textColor =UIColorFromRGB(0x333333);
    }
    
    return cell;
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 30)];
    view.backgroundColor = self.view.backgroundColor;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(23, view.height - 14, 200, 12)];
    label.font = TEXTFONT(12);
    label.textColor = UIColorFromRGB(0x999999);
    switch (section) {
        case 0:
            label.text = @"电梯信息";
            break;
        case 1:
            label.text = @"报修";
            break;
        case 2:
            label.text = @"维修";
            break;
        case 3:
            label.text = @"追加报警";
            break;
        default:
            break;
    }
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3 && indexPath.section == 0)
    {
        NSArray *array2 = valueArray[indexPath.section];
        NSString *valueStr = [NSString stringWithFormat:@"%@",array2[indexPath.row]];
        float width1 = KWindowWidth - 25 - 73;
        NSInteger hRow = valueStr.length * 14 / width1;
        return 49 + hRow * 14;
    }
    
    if (indexPath.section == 3){
        
        NSArray *array1 = keyArray[indexPath.section];
        NSString *str1 = array1[2];
        NSArray *array2 = valueArray[indexPath.section];

        if (array1.count == 3) {
            return 49;
        }
        else
        {
            if (array1.count == 4)
            {
                if ([str1 isEqualToString:@"追加报修物业名称:"]) {
                    if (indexPath.row == 3) {
                        NSString *tempstr = array2[3];
                        float width1 = KWindowWidth - 25 - 73;
                        NSInteger hRow = [self countTheStrLength:tempstr] * 14 / width1;
                        return 49 + hRow * 14;
                    }
                }
                else
                {
                    if (indexPath.row == 2) {
                        NSString *tempstr = array2[2];
                        float width1 = KWindowWidth - 25 - 73;
                        NSInteger hRow = [self countTheStrLength:tempstr] * 14 / width1;
                        return 49 + hRow * 14;
                    }
                }
            }
            else
            {
                if (indexPath.row == 2) {
                    NSString *tempstr = array2[2];
                    float width1 = KWindowWidth - 25;
                    NSInteger hRow = [self countTheStrLength:tempstr] * 14 / width1;
                    return 49 + hRow * 14;
                }
                if (indexPath.row == 4) {
                    NSString *tempstr = array2[4];
                    float width1 = KWindowWidth - 25;
                    NSInteger hRow = [self countTheStrLength:tempstr] * 14 / width1;
                    return 49 + hRow * 14;
                }
            }
            
        }
        
    }
    
    
    return 49;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyAlarmDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 3 && indexPath.row > 0){
        
        NSMutableArray *array1 = [NSMutableArray arrayWithArray:keyArray[indexPath.section]];
        NSMutableArray *array2 = [NSMutableArray arrayWithArray:valueArray[indexPath.section]];
        NSString *str1 = array1[2];
        
        if (array1.count == 3) {
            cell.stateBtn.selected = !cell.stateBtn.selected;
            if (cell.stateBtn) {
                if (indexPath.row == 1) {
                    [array1 insertObject:@"" atIndex:2];
                    [array2 insertObject:yezhuName atIndex:2];
                    [keyArray replaceObjectAtIndex:3 withObject:array1];
                    [valueArray replaceObjectAtIndex:3 withObject:array2];
                    [self.tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                }
                else
                {
                    [array1 insertObject:@"" atIndex:3];
                    [array2 insertObject:wuyeName atIndex:3];
                    [keyArray replaceObjectAtIndex:3 withObject:array1];
                    [valueArray replaceObjectAtIndex:3 withObject:array2];
                    [self.tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                }
            }
        }
        else if (array1.count == 4)
        {
            if ([str1 isEqualToString:@"追加报修物业名称:"]) {
                if (indexPath.row < 3) {
                    cell.stateBtn.selected = !cell.stateBtn.selected;
                    if (indexPath.row == 1) {
                        [array1 insertObject:@"" atIndex:2];
                        [array2 insertObject:yezhuName atIndex:2];
                        [keyArray replaceObjectAtIndex:3 withObject:array1];
                        [valueArray replaceObjectAtIndex:3 withObject:array2];
                        [self.tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                        
                    }
                    if (indexPath.row == 2)
                    {
                        [array1 removeObjectAtIndex:3];
                        [array2 removeObjectAtIndex:3];
                        [keyArray replaceObjectAtIndex:3 withObject:array1];
                        [valueArray replaceObjectAtIndex:3 withObject:array2];
                        [self.tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                        
                    }
                }
            }
            else
            {
                if (indexPath.row != 2) {
                    cell.stateBtn.selected = !cell.stateBtn.selected;
                    if (indexPath.row == 1) {
                        [array1 removeObjectAtIndex:2];
                        [array2 removeObjectAtIndex:2];
                        [keyArray replaceObjectAtIndex:3 withObject:array1];
                        [valueArray replaceObjectAtIndex:3 withObject:array2];
                        [self.tableview deleteRowsAtIndexPaths: @[[NSIndexPath indexPathForRow:2 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                    }
                    if (indexPath.row == 3)
                    {
                        [array1 insertObject:@"" atIndex:4];
                        [array2 insertObject:wuyeName atIndex:4];
                        [keyArray replaceObjectAtIndex:3 withObject:array1];
                        [valueArray replaceObjectAtIndex:3 withObject:array2];
                        [self.tableview insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                    }
                }
            }
        }
        else
        {
            if (indexPath.row == 1 || indexPath.row == 3) {
                cell.stateBtn.selected = !cell.stateBtn.selected;
                if (indexPath.row == 1) {
                    [array1 removeObjectAtIndex:2];
                    [array2 removeObjectAtIndex:2];
                    [keyArray replaceObjectAtIndex:3 withObject:array1];
                    [valueArray replaceObjectAtIndex:3 withObject:array2];
                    [self.tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                    
                }
                if (indexPath.row == 3)
                {
                    [array1 removeObjectAtIndex:4];
                    [array2 removeObjectAtIndex:4];
                    [keyArray replaceObjectAtIndex:3 withObject:array1];
                    [valueArray replaceObjectAtIndex:3 withObject:array2];
                    [self.tableview deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:4 inSection:3]] withRowAnimation:UITableViewRowAnimationTop];
                    
                }
            }
        }
        
        
        
    }

}

#pragma mark - button click
- (IBAction)zhuijiaClick:(id)sender {
    
    _propertyVC.sender = @"zhuijiagaojing";
    EvevatorModel *model = [[EvevatorModel alloc] init];
    model.alarmId = alarmId;
    NSArray *array = valueArray[0];
    model.innerid = array[0];
    model.location = array[1];
    _propertyVC.model = model;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    _propertyVC = [segue destinationViewController];
}


@end
