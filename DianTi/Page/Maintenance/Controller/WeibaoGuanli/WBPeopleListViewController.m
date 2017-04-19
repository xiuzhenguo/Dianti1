//
//  WBPeopleListViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/13.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBPeopleListViewController.h"
#import "WBPeopleListCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"
#import "ReporterModel.h"
#import "PersonInformation.h"

#import "UITableView+Refresh.h"
#import "UIImage+Color.h"
@interface WBPeopleListViewController ()
{
    NSMutableArray *peopleArray;
}

@property (nonatomic) NSInteger pageNum;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *tfView;
@property (weak, nonatomic) IBOutlet UITextField *nameTF;


@end

@implementation WBPeopleListViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableview.mj_header beginRefreshing];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(self.nameTF.width - 44, 0, 5, self.nameTF.height)];
    bgview.backgroundColor = UIColorFromRGB(0xdddddd);
    [self.nameTF addSubview:bgview];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.nameTF.width - 44, 0, 44, self.nameTF.height);
    [self.nameTF addSubview:button];
    
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [button setBackgroundImage:[UIImage createImageWithColor:UIColorFromRGB(0xdddddd)] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"WBSousuo"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(KWindowWidth - 50, self.tableview.bottom, 50, 30)];
    label.font = TEXTFONT(12);
    label.textColor = kMainColor;
    label.text = @"可多选";
    [self.view addSubview:label];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
}

- (void)setupSubview
{
    self.navigationItem.title = @"维修人员";
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    
    [_tableview addRefreshHeaderBlock:^{
        weakSelf.pageNum  = 1;
        [weakSelf loadDataWithName:self.nameTF.text];
    }];
    [_tableview addRefreshFooterBlock:^{
        weakSelf.pageNum++;
        [weakSelf loadDataWithName:self.nameTF.text];
    }];
    
    self.tableview.separatorColor = [UIColor clearColor];
    self.tableview.showsVerticalScrollIndicator = NO;
    self.tableview.backgroundColor = [UIColor clearColor];
}

-(void)chooseBlessingMeg{
    [self.tableview.mj_header endRefreshing];
    [self.tableview.mj_footer endRefreshing];
    [self.tableview reloadData];
}

- (void)loadDataWithName:(NSString *)name
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getStaffListWithWBid:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"10" where:self.nameTF.text staffid:[PersonInformation sharedPersonInformation].staffid power:[PersonInformation sharedPersonInformation].power success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableview showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            peopleArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 10){
                
                [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < 10){
                
                [weakSelf.tableview.mj_footer endRefreshingWithNoMoreData];
            }
            [peopleArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableview reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadDataWithName:weakSelf.nameTF.text];
            }];
        }
        
    }];
    
}

#pragma mark - table delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return peopleArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBPeopleListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
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
    ReporterModel *model = peopleArray[indexPath.row];
    for (ReporterModel *model1 in self.array) {
        if ([model.reporterID isEqualToString:model1.reporterID]) {
            model.state = @"1";
        }
    }
    cell.model = model;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    ReporterModel *model = peopleArray[indexPath.row];
    if (self.array.count > 0) {
        for (int i = 0; i < self.array.count; i++) {
            ReporterModel *model1 = self.array[i];
            if ([model.reporterID isEqualToString:model1.reporterID]) {
                [self.array removeObjectAtIndex:i];
                model.state = @"0";
                WBPeopleListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
                cell.model = model;
                [tableView deselectRowAtIndexPath:indexPath animated:YES];
                return;
            }
        }

    }
    
    model.state = @"1";
    [self.array addObject:model];
    WBPeopleListCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.model = model;
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

#pragma mark - button click
- (void)sousuo
{
    [self loadDataWithName:self.nameTF.text];
}

- (IBAction)sureClick:(id)sender {
    
    if (self.array.count > 0) {
        [self.navigationController popViewControllerAnimated:YES];
        for (int i = 0; i < self.array.count; i++) {
            for (int j = 0; j < i; j++) {
                ReporterModel *model1 = self.array[i];
                ReporterModel *model2 = self.array[j];
                if (model2.reporterID > model1.reporterID) {
                    [self.array replaceObjectAtIndex:i withObject:model2];
                    [self.array replaceObjectAtIndex:j withObject:model1];
                }
            }
        }
        if (self.chooseFinish) {
            self.chooseFinish(self.array);
        }
    }
    else
    {
        [self.view showHudMessage:@"请选择人员"];
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
