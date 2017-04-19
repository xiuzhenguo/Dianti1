//
//  OwnerMyRecordViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/23.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerMyRecordViewController.h"
#import "PropertyManager.h"
#import "OwnerManager.h"
#import "EvevatorModel.h"
#import "UITableView+Refresh.h"
#import "PropertyMineCell.h"
#import "PersonInformation.h"
#import "DividingLine.h"
@interface OwnerMyRecordViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray *mineArray;
    UIView *bgview;
    UIView *contentView;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSInteger pageNum;
@property (nonatomic) NSInteger row;
@end

@implementation OwnerMyRecordViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.tableView.mj_header beginRefreshing];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的报修记录";
    [self setupSubview];
}


- (void)loadData
{
    
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    
    [OwnerManager getMyRepairListWithOID:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"10" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            mineArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [mineArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
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

-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

- (void)setupSubview
{
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    
    [_tableView addRefreshHeaderBlock:^{
        weakSelf.pageNum  = 1;
        [weakSelf loadData];
    }];
    [_tableView addRefreshFooterBlock:^{
        weakSelf.pageNum++;
        [weakSelf loadData];
    }];
    
    self.tableView.allowsSelection = NO;
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}



#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  mineArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PropertyMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    EvevatorModel *model = mineArray[indexPath.row];
    cell.model = model;
    cell.Indexrow = indexPath.row;
    __weak typeof(self) weakSelf = self;
    cell.choosefinish = ^(NSInteger row){
        weakSelf.row = row;
        [weakSelf popDeleteView];
    };
    
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

- (void)popDeleteView
{
    bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor grayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(10, (KWindowHeight - (KWindowWidth - 20) / 1156 * 734) / 4, KWindowWidth - 20, (KWindowWidth - 20) / 1156 * 734)];
    contentView.layer.cornerRadius = 10;
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderWidth = 1;
    contentView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, 0, contentView.width - 80, contentView.height / 734 * 134)];
    label.text = @"提示";
    label.textColor = UIColorFromRGB(0x333333);
    label.textAlignment = 1;
    [contentView addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"regist_close"] forState:UIControlStateNormal];
    button.size = CGSizeMake(30, 25);
    button.center = CGPointMake(contentView.width - 40, label.centerY);
    [contentView addSubview:button];
    
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.size = CGSizeMake(contentView.width - 40, (KWindowWidth - 60) /  1040 * 134);
    sure.center = CGPointMake(contentView.width / 2, contentView.height  - 60);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setBackgroundImage:[UIImage imageNamed:@"login_loginBtn_normal"] forState:UIControlStateNormal];
    [contentView addSubview:sure];
    
    [sure addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, label.bottom, contentView.width, 1)];
    [contentView addSubview:line];
    float dis = 35 * KWindowHeight / 736;
    float lineBottom = line.bottom + dis;
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, lineBottom, contentView.width, 16)];
    label2.text = @"你确定删除吗?";
    label2.textColor = UIColorFromRGB(0x666666);
    label2.textAlignment = 1;
    label2.font = TEXTFONT(16);
    [contentView addSubview:label2];
    
}
- (void)close
{
    [contentView removeFromSuperview];
    [bgview removeFromSuperview];
}

- (void)queding
{
    __weak typeof(self) weakself = self;
    EvevatorModel *model = mineArray[self.row];
    [self.view showHudWithActivity:@"正在加载"];
    [PropertyManager alarmDeleteWithAid:model.alarmId success:^(id responseObject) {
        
        [weakself.view hideHubWithActivity];
        [mineArray removeObjectAtIndex:weakself.row];
        [weakself.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:weakself.row inSection:0]] withRowAnimation:UITableViewRowAnimationLeft];
        [contentView removeFromSuperview];
        [bgview removeFromSuperview];
        
    } failure:^(NSError *error) {
        [weakself.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakself.view showHudMessage:error.localizedDescription];
        }else{
            [weakself.view showHudMessage:@"网络异常"];
        }
    }];
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
