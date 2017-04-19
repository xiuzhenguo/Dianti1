//
//  WBLeftBaoyangViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/13.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBLeftBaoyangViewController.h"
#import "PropertyFaultListViewController.h"
#import "WBPeopleListViewController.h"
#import "WBContentChooseViewController.h"

#import "HcdDateTimePickerView.h"
#import "PropertyAlarmDetailTableViewCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"

#import "PersonInformation.h"
#import "EvevatorModel.h"
#import "FaultModel.h"
#import "ReporterModel.h"
#import "AreaModel.h"

@interface WBLeftBaoyangViewController ()
{
    HcdDateTimePickerView * dateTimePickerView;
    
    NSArray *keyArray;
    NSMutableArray *valueArray;
    
    NSString *_people;
    NSString *_peopleID;
    
    NSString *_concent;
    NSString *_concentID;
    
    NSArray *baoyangArray;
    
    NSArray *peopleArray;
}

@property (weak, nonatomic) IBOutlet UITableView *tableview;


@end

@implementation WBLeftBaoyangViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupView];
    [self loadData];
}

- (void)setupView
{
    self.navigationItem.title = @"电梯保养";
//    self.tableview.allowsSelection = NO;
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.backgroundColor = [UIColor clearColor];
    
}

- (void)loadData
{
    keyArray = @[@"电梯编号：",@"电梯位置：",@"更改状态：",@"设置保养内容：",@"设置下次保养时间：",@"操作人："];
    valueArray = [NSMutableArray arrayWithObjects:self.model.innerid,self.model.location,@"正在保养",@"",@"",@"", nil];
    [self.tableview reloadData];
}

#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  keyArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyAlarmDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    cell.key.text = [NSString stringWithFormat:@"%@",keyArray[indexPath.row]];
    cell.keyStr = [NSString stringWithFormat:@"%@",keyArray[indexPath.row]];
    
    cell.value.text = [NSString stringWithFormat:@"%@",valueArray[indexPath.row]];
    cell.valueStr = [NSString stringWithFormat:@"%@",keyArray[indexPath.row]];
    
    
    
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
    
    if (indexPath.row == 2) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
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
        cell.valueWidth.constant = cell.valueWidth.constant;
    }
    if (indexPath.row == 3) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(KWindowWidth - 85, 7, 80, 35);
        btn.layer.cornerRadius = 5;
        btn.layer.masksToBounds = YES;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = kMainColor.CGColor;
        btn.titleLabel.font = TEXTFONT(15);
        [btn setTitle:@"保养内容" forState:UIControlStateNormal];
        [btn setTitleColor:kMainColor forState:UIControlStateNormal];
        [cell.contentView addSubview:btn];
        [btn addTarget:self action:@selector(baoyangChoose) forControlEvents:UIControlEventTouchUpInside];
        cell.valueWidth.constant = KWindowWidth - 210;
    }
    
    if (indexPath.row == 5) {
        UIImageView *imageV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"youjiantou"]];
        imageV.frame = CGRectMake(KWindowWidth -38, 10.5, 18, 28);
        [cell.contentView addSubview:imageV];
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

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    __weak typeof(self) weakself = self;
    __weak typeof(valueArray) weakValuearray = valueArray;
    if (indexPath.row == 4) {
        dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:1000]];
        [dateTimePickerView setMinYear:2016];
        [dateTimePickerView setMaxYear:2030];
        
        dateTimePickerView.title = @"保养时间";
        dateTimePickerView.titleColor = [UIColor yellowColor];
        
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            PropertyAlarmDetailTableViewCell *cell = [weakself.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
            cell.value.text = [NSString stringWithFormat:@"%@",datetimeStr];
            [weakValuearray replaceObjectAtIndex:4 withObject:datetimeStr];
        };
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }
    
    
    if (indexPath.row == 5) {
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

                PropertyAlarmDetailTableViewCell *cell = [weakself.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
                cell.value.text = [NSString stringWithFormat:@"%@",tempStr];
                [weakValuearray replaceObjectAtIndex:5 withObject:tempStr];
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
    areaList.view.frame = CGRectMake(10, (KWindowHeight - 270) / 3, KWindowWidth - 20, 270);
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
            
            PropertyAlarmDetailTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
            cell.value.text = [NSString stringWithFormat:@"%@",model.details];
            [valueArray replaceObjectAtIndex:2 withObject:model.details];
            
            
        }
        [bgview removeFromSuperview];
    };
    
    areaList.sender = [NSString stringWithFormat:@"stateList2"];
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];
    
}
- (void)viewWillLayoutSubviews
{
    [self hideTabBar];
}

- (void)baoyangChoose
{
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    WBContentChooseViewController *contentVC = [[WBContentChooseViewController alloc] init];
    contentVC.view.frame = CGRectMake(10, 70, KWindowWidth - 20, 360);
    contentVC.view.layer.cornerRadius = 10;
    contentVC.view.layer.masksToBounds = YES;
    contentVC.view.layer.borderWidth = 1;
    contentVC.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contentVC.view.backgroundColor = [UIColor whiteColor];
    
    contentVC.chooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            
            baoyangArray = array;
            
            NSMutableString *tempStr = [NSMutableString string];
            NSMutableString *tempStr2 = [NSMutableString string];
            for (AreaModel *model in array) {
                [tempStr appendFormat:@"%@,",model.areaName];
                [tempStr2 appendFormat:@"%@,",model.areaID];
            }
            [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
            [tempStr2 deleteCharactersInRange:NSMakeRange(tempStr2.length - 1, 1)];
            _concent = tempStr;
            _concentID = tempStr2;
            
            PropertyAlarmDetailTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
            cell.value.text = [NSString stringWithFormat:@"%@",tempStr];
            [valueArray replaceObjectAtIndex:3 withObject:tempStr];
            
            
        }
        [bgview removeFromSuperview];
    };
    if (baoyangArray != nil || baoyangArray.count > 0) {
        contentVC.array = [NSMutableArray arrayWithArray:baoyangArray];
    }
    [self addChildViewController:contentVC];
    [self.view addSubview:contentVC.view];
    
}

- (IBAction)insetBaoyang:(id)sender {
    
    PropertyAlarmDetailTableViewCell *stateCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    PropertyAlarmDetailTableViewCell *contentCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]];
    PropertyAlarmDetailTableViewCell *dateCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    PropertyAlarmDetailTableViewCell *peopelCell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    
    NSString *stateStr;
    if ([stateCell.value.text isEqualToString:@"正在保养"]) {
        stateStr = @"5";
    }
    else
    {
        stateStr = @"1";
    }
    
    if (contentCell.value.text.length == 0) {
        [self.view showHudMessage:@"请选择保养内容"];
        return;
    }
    if (dateCell.value.text.length == 0) {
        [self.view showHudMessage:@"请选择保养时间"];
        return;
    }
    if (peopelCell.value.text.length == 0) {
        [self.view showHudMessage:@"请选择操作人"];
        return;
    }
    
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager insertLiftMaintainWithLid:self.model.evevatorID wbid:[PersonInformation sharedPersonInformation].userID staffid:_peopleID nextcaredate:dateCell.value.text maintaintype:_concentID maintainstate:stateStr orgstate:@"5" success:^(id responseObject) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf.view showHudMessage:@"操作成功"];
        [weakSelf performBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        } afterDelay:1];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
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
