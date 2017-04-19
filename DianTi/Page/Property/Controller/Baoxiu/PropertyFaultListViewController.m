//
//  PropertyFaultListViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/8.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyFaultListViewController.h"
#import "PropertyFaultCell.h"
#import "DividingLine.h"

#import "FaultModel.h"
#import "AreaModel.h"

#import "PropertyManager.h"
#import "MaintenanceManager.h"

@interface PropertyFaultListViewController ()
{
    NSArray *_faultArray;
}
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UITextField *titleLabel;


@end

@implementation PropertyFaultListViewController

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([_sender isEqualToString:@"baoxiuDetail"] || [_sender isEqualToString:@"stateList"]) {
        [self hideTabBar];
    }
    else
    {
        [self showTabBar];
    }

    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tableview setBackgroundColor:self.view.backgroundColor];
    
}

- (void)setSender:(NSString *)sender
{
    _sender = sender;
    if ([sender isEqualToString:@"baoxiuDetail"]) {
        [self loadBaoxiuData];
    }
    if ([sender isEqualToString:@"typeList"]) {
        [self loadTypeListData];
    }
    if ([sender isEqualToString:@"areaList"]) {
        [self loadAreaListData];
    }
    if ([sender isEqualToString:@"stateList"]) {
        [self loadStateListData];
    }
    if ([sender isEqualToString:@"stateList2"]) {
        [self loadStateListData2];
    }
}

- (void)loadStateListData2
{
    self.titleLabel.text = @"更改状态";
    NSMutableArray *typeArray = [NSMutableArray array];
    NSArray *tempArray = @[@"正在保养",@"保养完成"];
    for (int i = 1; i < 3; i++) {
        FaultModel *model = [FaultModel new];
        model.state = @"0";
        model.faultI = [NSString stringWithFormat:@"%d",i];
        model.details = tempArray[i-1];
        [typeArray addObject:model];
    }
    _faultArray = typeArray;
    [self.tableview reloadData];
}

- (void)loadStateListData
{
    self.titleLabel.text = @"更改状态";
    NSMutableArray *typeArray = [NSMutableArray array];
    NSString *str = self.array[0];
    switch ([str integerValue]) {
        case 2:
        {
            NSArray *tempArray = @[@"维修完成",@"未处理",@"已受理",@"正在维修"];
            for (int i = 1; i < 5; i++) {
                FaultModel *model = [FaultModel new];
                model.state = @"0";
                model.faultI = [NSString stringWithFormat:@"%d",i];
                if (i == 1) {
                    model.faultI = [NSString stringWithFormat:@"%d",1];
                }
                model.details = tempArray[i-1];
                [typeArray addObject:model];
            }
            _faultArray = typeArray;
            [self.tableview reloadData];
        }
               break;
        case 3:
        {
            NSArray *tempArray = @[@"维修完成",@"已受理",@"正在维修"];
            for (int i = 1; i < 4; i++) {
                FaultModel *model = [FaultModel new];
                model.state = @"0";
                model.faultI = [NSString stringWithFormat:@"%d",i+1];
                if (i == 1) {
                    model.faultI = [NSString stringWithFormat:@"%d",1];
                }
                model.details = tempArray[i-1];
                [typeArray addObject:model];
            }
            _faultArray = typeArray;
            [self.tableview reloadData];
        }
               break;
        case 4:
        {
            NSArray *tempArray = @[@"维修完成",@"正在维修"];
            for (int i = 1; i < 3; i++) {
                FaultModel *model = [FaultModel new];
                model.state = @"0";
                model.faultI = [NSString stringWithFormat:@"%d",i+2];
                if (i == 1) {
                    model.faultI = [NSString stringWithFormat:@"%d",1];
                }
                model.details = tempArray[i-1];
                [typeArray addObject:model];
            }
            _faultArray = typeArray;
            [self.tableview reloadData];
        }
            break;
            
        default:
            break;
    };
    
}

- (void)loadTypeListData
{
    self.titleLabel.text = @"选择类型";
    NSMutableArray *typeArray = [NSMutableArray array];
    NSArray *tempArray = @[@"电梯维修",@"电梯保养"];
    for (int i = 1; i < 3; i++) {
        FaultModel *model = [FaultModel new];
        model.state = @"0";
        model.faultI = [NSString stringWithFormat:@"%d",i];
        model.details = tempArray[i-1];
        [typeArray addObject:model];
    }
    _faultArray = typeArray;
    [self.tableview reloadData];
}

- (void)loadAreaListData
{
    NSMutableArray *typeArray = [NSMutableArray array];
    for (AreaModel *area in _array) {
        FaultModel *model = [FaultModel new];
        model.state = @"0";
        model.faultI = area.areaID;
        model.details = area.areaName;
        [typeArray addObject:model];
    }
    _faultArray = typeArray;
    [self.tableview reloadData];
}

- (void)loadBaoxiuData
{
    self.titleLabel.text = @"故障类型";
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [PropertyManager getFaultListSuccess:^(id responseObject) {
        
        [weakSelf.view hideHubWithActivity];
        [weakSelf.view hidFailedView];
        _faultArray  = responseObject;
        for (FaultModel *model in _faultArray) {
            for (FaultModel *model1 in self.array) {
                if ([model.faultI isEqualToString:model1.faultI]) {
                    model.state = @"1";
                }
            }
        }
        [weakSelf.tableview reloadData];
    
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf loadBaoxiuData];
            }];
        }
    }];
}

- (IBAction)closeClick:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    if (self.chooseFinish) {
        self.chooseFinish(nil);
    }
}

- (IBAction)sureClick:(id)sender {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    NSMutableArray *tempArray = [NSMutableArray array];
    if (_faultArray.count > 0) {
        for (FaultModel *model in _faultArray) {
            if ([model.state integerValue] == 1) {
                [tempArray addObject:model];
            }
        }
    }
    if (self.chooseFinish) {
        self.chooseFinish(tempArray);
    }
}

#pragma mark table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _faultArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PropertyFaultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"faultCell" forIndexPath:indexPath];
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
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, cell.height - 0.5, KWindowWidth, 0.5)];
    [cell.contentView addSubview:line2];
    
    FaultModel *model = _faultArray[indexPath.row];
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([_sender isEqualToString:@"baoxiuDetail"]) {
        FaultModel *model = _faultArray[indexPath.row];
        if ([model.state integerValue] == 1) {
            model.state = @"0";
        }
        else
        {
            model.state = @"1";
        }
        PropertyFaultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.model = model;
    }
    else
    {
        for (int i = 0; i < _faultArray.count; i++) {
            PropertyFaultCell *cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
            FaultModel *model = _faultArray[i];
            model.state = @"0";
            cell.model = model;
        }
        PropertyFaultCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        FaultModel *model = _faultArray[indexPath.row];
        model.state = @"1";
        cell.model = model;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
