//
//  WeibaoTongzhiViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/12.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WeibaoTongzhiViewController.h"
#import "WBNoticeDetailViewController.h"
#import "WBNoticeCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"
#import "PersonInformation.h"
#import "NoticeModel.h"

#import "UITableView+Refresh.h"
#import "UITabBar+Badge.h"

@interface WeibaoTongzhiViewController ()
{
    NSMutableArray *itemArray;
    UIView *bgview;
    UIView *contentView;
}

@property (nonatomic, strong) WBNoticeDetailViewController *showVC;
@property (nonatomic) NSInteger row;
@property (nonatomic) NSInteger pageNum;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WeibaoTongzhiViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    [self.tabBarController.tabBar hideBadgeOnItemIndex:3];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubview];
}

- (void)setupSubview
{
    
    self.navigationItem.title = @"通知";
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
    
    self.tableView.separatorColor = [UIColor clearColor];
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getNoticeListWithWBid:[PersonInformation sharedPersonInformation].userID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:[NSString stringWithFormat:@"%d",kGetNumberOfData] success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [weakSelf.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count<kGetNumberOfData){
                
                [weakSelf.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [itemArray addObjectsFromArray:tempArray];
        }
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf chooseBlessingMeg];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
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
#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WBNoticeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    __weak typeof(self) weakSelf = self;
    MGSwipeButton *button = [MGSwipeButton buttonWithTitle:@"删除" backgroundColor:[UIColor redColor] callback:^BOOL(MGSwipeTableCell * _Nonnull cell) {
        weakSelf.row = indexPath.row;
        [weakSelf popDeleteView];
        return YES;
    }];
    cell.rightButtons = @[button];
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
    
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NoticeModel *model = itemArray[indexPath.row];
    cell.model = model;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NoticeModel *model = itemArray[indexPath.row];
    _showVC.model = model;
}

#pragma mark - delete
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
    NoticeModel *model = itemArray[self.row];
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getTongzhiDeleteWithNid:model.noticeID success:^(id responseObject) {
        
        [weakself.view hideHubWithActivity];
        [itemArray removeObjectAtIndex:weakself.row];
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


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    _showVC = [segue destinationViewController];
}


@end
