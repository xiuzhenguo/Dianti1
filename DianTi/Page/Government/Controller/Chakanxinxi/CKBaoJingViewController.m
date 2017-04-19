//
//  CKBaoJingViewController.m
//  DianTi
//
//  Created by 云彩 on 2017/4/10.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKBaoJingViewController.h"
#import "GoveCkManager.h"
#import "UITableView+Refresh.h"
#import "DividingLine.h"
#import "CKBaoJingTableViewCell.h"
#import "CKBaoJingView.h"
#import "CKProView.h"
#import "CKBJDetailViewController.h"

@interface CKBaoJingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageNum;
@property (nonatomic, strong) NSMutableArray *itemArray;
@property (nonatomic, strong) UILabel *villLab;
@property (nonatomic, strong) UIButton *proBtn;
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) UIButton *areaBtn;
@property (nonatomic, strong) NSString *proID;
@property (nonatomic, strong) NSString *cityID;
@property (nonatomic, strong) NSString *areaID;
@property (nonatomic, strong) NSString *villageID;

@end

@implementation CKBaoJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    self.title = @"报修信息";
    self.pageNum = 1;
    
    [self setUpHeaderViewUI];
    
    [self setUpTableView];
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    [_tableView addRefreshHeaderBlock:^{
        if (weakSelf.villageID.length == 0) {
            [weakSelf.view showHudMessage:@"请选择小区"];
            [weakSelf.tableView.mj_header endRefreshing];
            weakSelf.itemArray = [[NSMutableArray array] init];
            [weakSelf.tableView reloadData];
            return;
        }
        weakSelf.pageNum  = 1;
        [weakSelf loadDataWith:weakSelf.villageID];
    }];
    [_tableView addRefreshFooterBlock:^{
        weakSelf.pageNum++;
        [weakSelf loadDataWith:weakSelf.villageID];
    }];

}

- (void)loadDataWith:(NSString *)areaID
{
    __weak typeof(self) weakSelf = self;
    [GoveCkManager getEvevatorListWithVID:areaID pageindex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pagesize:@"10" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [self.tableView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            _itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 10){
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < 10){
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
            }
            [self.itemArray addObjectsFromArray:tempArray];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
//                [weakSelf loadData];
            }];
        }
    }];
}

-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

#pragma mark - 创建tableView
-(void) setUpTableView {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 106, KWindowWidth, KWindowHeight-106 - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerNib:[UINib nibWithNibName:@"CKBaoJingTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CKBaoJingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.model = self.itemArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CKBJDetailViewController *vc = [[CKBJDetailViewController alloc] init];
    GaoJingModel *model = self.itemArray[indexPath.row];
    vc.stateStr = model.lstate;
    vc.strLid = model.lid;
    vc.inneridStr = model.linnerid;
    vc.lbuildnoStr = model.lbuildno;
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建城市选择按钮
- (void) setUpHeaderViewUI {
    NSArray *arr = @[@"省：请选择",@"市：请选择",@"区：请选择"];
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KWindowWidth, 86)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    for (int i = 0; i<3; i++) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(20+(KWindowWidth-40)/3.0*i, 10, (KWindowWidth-40)/3.0, 43)];
        [btn setTitleColor:kTextColor forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        [btn addTarget:self action:@selector(clickProButton:) forControlEvents:UIControlEventTouchUpInside];
        btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        btn.tag = 1000+i;
        if (i == 0) {
            self.proBtn = btn;
        }else if (i == 1){
            self.cityBtn = btn;
        }else{
            self.areaBtn = btn;
        }
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(btn.frame.size.width - 25, 16, 15, 10)];
        img.image = [UIImage imageNamed:@"gaojing_xiala"];
        [btn addSubview:img];
        
        DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 9.5+43*i, KWindowWidth, 0.5)];
        [self.view addSubview:line];
    }
    
    UIButton *villageBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 85, 59, 70, 30)];
    villageBtn.layer.borderWidth = 1;
    villageBtn.layer.borderColor = kMainColor.CGColor;
    villageBtn.layer.cornerRadius = 4;
    villageBtn.layer.masksToBounds = YES;
    [villageBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [villageBtn setTitle:@"小区" forState:UIControlStateNormal];
    villageBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [villageBtn addTarget:self action:@selector(clickVillageButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:villageBtn];
    
    self.villLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 53, KWindowWidth - 60, 43)];
    self.villLab.text = @"选择小区：请选择小区";
    self.villLab.font = [UIFont systemFontOfSize:14];
    self.villLab.textColor = kTextColor;
    [self.view addSubview:self.villLab];
}

-(void) clickProButton:(UIButton *)sender {
    self.villLab.text = @"选择小区：请选择小区";
    self.villageID = @"";
    if (sender.tag == 1000) {
        [self.cityBtn setTitle:@"市：请选择" forState:UIControlStateNormal];
        [self.areaBtn setTitle:@"区：请选择" forState:UIControlStateNormal];
        [self loadGoveData];
    }else if (sender.tag == 1001){
        [self.areaBtn setTitle:@"区：请选择" forState:UIControlStateNormal];
        if ([self.proBtn.titleLabel.text isEqualToString:@"省：请选择"]) {
            [self.view showHudMessage:@"请先选择省"];
            return;
        }
        [self loadCityData];
    }else{
        if ([self.cityBtn.titleLabel.text isEqualToString:@"市：请选择"]) {
            [self.view showHudMessage:@"请先选择市"];
            return;
        }
        [self loadAreaData];
    }
}

-(void) clickVillageButton {
    if ([self.areaBtn.titleLabel.text isEqualToString:@"区：请选择"]) {
        [self.view showHudMessage:@"请先选择区"];
        return;
    }
    [self loadVillageData];
}



-(void) loadGoveData {
    __weak typeof(self) weakSelf = self;
    [GoveCkManager getGovAreaOptionListSuccess:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;

        CKProView *backview = [[CKProView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        backview.titleStr = @"省";
        backview.dataSource = [NSMutableArray arrayWithArray:tempArray];
        [self.view addSubview:backview];
        
        [backview setFinishButtonTitStr:^(NSString *name){
            NSString *str = [NSString stringWithFormat:@"省：%@",name];
            [self.proBtn setTitle:str forState:UIControlStateNormal];
        }];
        [backview setFinishButtonTitID:^(NSString *strID){
            self.proID = strID;
            
        }];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                //                [weakSelf loadData];
            }];
        }
    }];
}

-(void) loadCityData {
    __weak typeof(self) weakSelf = self;
    [GoveCkManager getCityAreaOptionListWithPid:self.proID success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        
        CKProView *backview = [[CKProView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        backview.titleStr = @"市";
        backview.dataSource = [NSMutableArray arrayWithArray:tempArray];
        [self.view addSubview:backview];
        
        [backview setFinishButtonTitStr:^(NSString *name){
            NSString *str = [NSString stringWithFormat:@"市：%@",name];
            [self.cityBtn setTitle:str forState:UIControlStateNormal];
        }];
        [backview setFinishButtonTitID:^(NSString *strID){
            self.cityID = strID;
            
        }];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                //                [weakSelf loadData];
            }];
        }
    }];
}

-(void) loadAreaData {
    __weak typeof(self) weakSelf = self;
    [GoveCkManager getAreaAreaOptionListWithCid:self.cityID type:@"aa" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        
        CKProView *backview = [[CKProView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        backview.titleStr = @"市";
        backview.dataSource = [NSMutableArray arrayWithArray:tempArray];
        [self.view addSubview:backview];
        
        [backview setFinishButtonTitStr:^(NSString *name){
            NSString *str = [NSString stringWithFormat:@"区：%@",name];
            [self.areaBtn setTitle:str forState:UIControlStateNormal];
        }];
        [backview setFinishButtonTitID:^(NSString *strID){
            self.areaID = strID;
            
        }];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                //                [weakSelf loadData];
            }];
        }
    }];
}

-(void) loadVillageData {
    __weak typeof(self) weakSelf = self;
    NSString *area = [NSString stringWithFormat:@"%@,%@,%@",self.proID,self.cityID,self.areaID];
    [GoveCkManager getVillageAreaOptionListWithArea:area type:@"a" kind:@"a" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        
        CKBaoJingView *backview = [[CKBaoJingView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        backview.titleStr = @"选择小区";
        backview.dataArray = [NSMutableArray arrayWithArray:tempArray];
        [self.view addSubview:backview];
        
        [backview setFinishButtonTitleStr:^(NSString *name){
            NSString *str = [NSString stringWithFormat:@"选择小区：%@",name];
            self.villLab.text = str;
        }];
        [backview setFinishButtonTitleID:^(NSString *strID){
            self.villageID = strID;
            [self loadDataWith:self.villageID];
        }];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                //                [weakSelf loadData];
            }];
        }
    }];
}

@end
