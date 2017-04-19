//
//  WBDianTiGaoJingViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/23.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WBDianTiGaoJingViewController.h"
#import "PropertyFaultListViewController.h"
#import "WBPeopleListViewController.h"

#import "PropertyAlarmDetailTableViewCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"

#import "PersonInformation.h"
#import "FaultModel.h"
#import "ReporterModel.h"
@interface WBDianTiGaoJingViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *keyArray;
    NSMutableArray *valueArray;
    NSArray *stateArray;
    
    NSString *_type;
    NSString *_people;
    NSString *_peopleID;
    
    NSArray *peopleArray;
}

@property (nonatomic, copy) NSString *alarmID;
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end

@implementation WBDianTiGaoJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self loadData];
}

- (void)setupView
{
    self.navigationItem.title = @"电梯维修";
    //    self.tableview.allowsSelection = NO;
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.backgroundColor = [UIColor clearColor];
}

- (void)loadData
{
    _type = @"";
    _people = @"";
    NSArray *array1 = @[_lid,_location,_state];
    NSArray *array4 = @[_type,_people];
    
    NSArray *newArray = @[array1,array4];
    
    valueArray = [NSMutableArray arrayWithArray:newArray];
    keyArray = @[@[@"电梯编号：",@"电梯位置：",@"电梯状态："],@[@"更改状态：",@"操作人："]];
    [self.tableview reloadData];
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
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *array1 = keyArray[indexPath.section];
    cell.key.text = [NSString stringWithFormat:@"%@",array1[indexPath.row]];
    cell.key.text = [NSString stringWithFormat:@"%@",array1[indexPath.row]];
    
    NSArray *array2 = valueArray[indexPath.section];
    cell.valueStr = [NSString stringWithFormat:@"%@",array2[indexPath.row]];
    cell.value.text = [NSString stringWithFormat:@"%@",array2[indexPath.row]];
    //    cell.valueWidth.constant = KWindowWidth - cell.key.right - 14 * cell.key.text.length - 10;
    
    
    if (indexPath.row == 0 && indexPath.section == 1) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = 108;
        btn.frame = CGRectMake(KWindowWidth - 85, 7, 80, 35);
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = kMainColor.CGColor;
        btn.titleLabel.font = TEXTFONT(15);
        [btn setTitle:@"更改状态" forState:UIControlStateNormal];
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        [cell.contentView addSubview:btn];
        [btn addTarget:self action:@selector(stateChoose) forControlEvents:UIControlEventTouchUpInside];
        cell.valueWidth.constant = cell.valueWidth.constant - 90;
    }
    else
    {
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 108) {
                [view removeFromSuperview];
            }
        }
    }
    
    
    if (indexPath.row == 1 && indexPath.section == 1) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"youjiantou"]];
        imageV.tag = 107;
        imageV.frame = CGRectMake(KWindowWidth -38, 10.5, 18, 28);
        [cell.contentView addSubview:imageV];
    }
    else
    {
        for (UIView *view in cell.contentView.subviews) {
            if (view.tag == 107) {
                [view removeFromSuperview];
            }
        }
    }
    
    
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
    PropertyAlarmDetailTableViewCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(cell.key.left, view.height - 14, 200, 12)];
    label.font = TEXTFONT(12);
    label.textColor = UIColorFromRGB(0x999999);
    switch (section) {
        case 0:
            label.text = @"电梯信息";
            break;
        case 1:
            label.text = @"";
            break;
            
        default:
            break;
    }
    [view addSubview:label];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 49;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1 && indexPath.section == 1) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
        WBPeopleListViewController *peopleVC = [storyboard instantiateViewControllerWithIdentifier:@"PeopleList"];
        [self.navigationController pushViewController:peopleVC animated:YES];
        if (peopleArray.count == 0 || peopleArray == nil) {
            peopleVC.array = [NSMutableArray array];
        }
        else
        {
            peopleVC.array = [NSMutableArray arrayWithArray:peopleArray];
        }
        peopleVC.chooseFinish = ^(NSArray *array){
            if (array == nil || array.count == 0) {
                
            }
            else
            {
                peopleArray = array;
                NSMutableString *tempStr = [NSMutableString string];
                NSMutableString *tempStr2 = [NSMutableString string];
                for (ReporterModel *model in array) {
                    [tempStr appendFormat:@"%@,",model.jobID];
                    [tempStr2 appendFormat:@"%@,",model.reporterID];
                }
                [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
                [tempStr2 deleteCharactersInRange:NSMakeRange(tempStr2.length - 1, 1)];
                _people = tempStr;
                _peopleID = tempStr2;
                NSMutableArray *mArray = [NSMutableArray arrayWithArray:valueArray[1]];
                [mArray replaceObjectAtIndex:1 withObject:_people];
                [valueArray replaceObjectAtIndex:1 withObject:mArray];
                PropertyAlarmDetailTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:1]];
                cell.value.text = [NSString stringWithFormat:@"%@",tempStr];
            }
            
        };
    }
    
}

#pragma mark - button click
- (void)stateChoose
{
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    PropertyFaultListViewController *areaList = [storyboard instantiateViewControllerWithIdentifier:@"FaultAreaList"];
    areaList.view.frame = CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 370 * KWindowHeight / 768);
    areaList.view.layer.cornerRadius = 10;
    areaList.view.layer.masksToBounds = YES;
    areaList.view.layer.borderWidth = 1;
    areaList.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    areaList.view.backgroundColor = [UIColor whiteColor];
    
    areaList.chooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            
            FaultModel *model = array[0];
            
            PropertyAlarmDetailTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]];
            
            stateArray = array;
            
            
            _type = model.details;
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:valueArray[1]];
            [mArray replaceObjectAtIndex:0 withObject:_type];
            [valueArray replaceObjectAtIndex:1 withObject:mArray];
            cell.value.text = [NSString stringWithFormat:@"%@",model.details];
            
            
            
            
        }
        [bgview removeFromSuperview];
    };
    NSString *oldState = @"4";
    areaList.array = [NSMutableArray arrayWithObject:oldState];
    areaList.sender = [NSString stringWithFormat:@"stateList"];
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];
    [self hideTabBar];
}

- (IBAction)insertRecord:(id)sender {
    if (_type.length == 0 || [_type isEqualToString:@"不可往回选择"])
    {
        [self.view showHudMessage:@"请更改状态"];
        return;
    }
    if (_people.length == 0)
    {
        [self.view showHudMessage:@"请选择员工"];
        return;
    }
    
    
    FaultModel *model = stateArray[0];
    
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getWBLiftRepairDetailAbNormalWithLid:_lid wbid:[PersonInformation sharedPersonInformation].userID staffid:_peopleID repairstate:model.faultI success:^(id responseObject) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf.view showHudMessage:@"操作成功"];
        [weakSelf performBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } afterDelay:1];
    } failure:^(NSError *error) {
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showHudMessage:@"网络异常"];
        }
    }];

    
    
    
    
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
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
