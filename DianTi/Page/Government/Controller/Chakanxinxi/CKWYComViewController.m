//
//  CKWYComViewController.m
//  DianTi
//
//  Created by 云彩 on 2017/4/13.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKWYComViewController.h"
#import "CKBaoJingView.h"
#import "DividingLine.h"
#import "GoveCkManager.h"
#import "GJAlarmDetailModel.h"
#import "CKWYComTableViewCell.h"

@interface CKWYComViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UILabel *wyLab;
@property (nonatomic, strong) NSString *wyStrId;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) NSArray *leftArray;
@property (nonatomic, strong) NSMutableArray *villageArray;
@property (nonatomic, strong) NSMutableArray *wysArray;
@property (nonatomic, strong) UILabel *comLab;
@property (nonatomic, strong) UILabel *addLab;
@property (nonatomic, strong) UILabel *phoLab;
@property (nonatomic, strong) UILabel *regNo;
@property (nonatomic, strong) UILabel *legalLab;
@property (nonatomic, strong) UILabel *reportNoLab;

@end

@implementation CKWYComViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.title = @"使用管理单位";
    
    self.leftArray = @[@"",@"单位地址：",@"法人代表：",@"联系电话：",@"使用登记证编号：",@"检验报告编号："];
    
    [self setUpWyCompanyView];
    
    [self setUpTableViewUI];
}

-(void) setUpTableViewUI {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 70, KWindowWidth, KWindowHeight - 64 - 70)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"commonbg"] ];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView registerClass:[CKWYComTableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.hidden = YES;
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 300)];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableHeaderView = self.headView;
    
    [self setUpTableHeaderViewUI];
}

-(void) setUpTableHeaderViewUI {
    UIView *back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 50)];
    back.backgroundColor = UIColorFromRGB(0xF8F8F8);
    [self.headView addSubview:back];
    
    for (int i = 0; i < 6; i++) {
        DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 50*i, KWindowWidth, 0.5)];
        [self.headView addSubview:line];
        
        UILabel *left = [[UILabel alloc] init];
        left.textColor = UIColorFromRGB(0x666666);
        left.font = [UIFont systemFontOfSize:14];
        left.text = self.leftArray[i];
        CGRect with = Adaptive_Width(left.text, left.font);
        left.frame = CGRectMake(15, 0.5+50*i, with.size.width, 49.5);
        [self.headView addSubview:left];
        
        UILabel *rightLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(left.frame), 0.5+50*i, KWindowWidth - CGRectGetMaxX(left.frame)-15, 49.5)];
        rightLab.textColor = kTextColor;
        rightLab.font = [UIFont systemFontOfSize:14];
        [self.headView addSubview:rightLab];
        switch (i) {
            case 0:
                self.comLab = rightLab;
                break;
            case 1:
                self.addLab = rightLab;
                break;
            case 2:
                self.legalLab = rightLab;
                break;
            case 3:
                self.phoLab = rightLab;
                break;
            case 4:
                self.regNo = rightLab;
                break;
            case 5:
                self.reportNoLab = rightLab;
                break;
            default:
                break;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.wysArray[section] isEqualToString:@"1"]) {
        return [self.villageArray[section] count];
    }else{
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CKWYComTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    GJAlarmDetailModel *model = self.villageArray[indexPath.section][indexPath.row];
    cell.nameLab.text = model.wyname;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = @[@"负责小区",@"电梯安全管理员"];
    UIButton *headView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 49.5)];
    [headView addTarget:self action:@selector(cilckHeaderButton:) forControlEvents:UIControlEventTouchUpInside];
    headView.tag = 1000+section;
    NSString *status = self.wysArray[section];
    headView.selected = status.boolValue;
    headView.backgroundColor = [UIColor whiteColor];
    
    UILabel *nameLab = [[UILabel alloc] init];
    nameLab.text = arr[section];
    nameLab.font = [UIFont systemFontOfSize:14];
    nameLab.textColor = UIColorFromRGB(0x666666);
    CGRect with = Adaptive_Width(nameLab.text, nameLab.font);
    nameLab.frame = CGRectMake(15, 0.5, with.size.width, 49);
    [headView addSubview:nameLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 40, 5, 40, 40)];
    if (headView.selected) {
        [btn setImage:[UIImage imageNamed:@"gaojing_xiala"] forState:UIControlStateNormal];
        
    }else{
        
        [btn setImage:[UIImage imageNamed:@"gaojing_shangla"] forState:UIControlStateNormal];
    }
    [headView addSubview:btn];
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    [headView addSubview:line1];
    
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 49.5, KWindowWidth, 0.5)];
    [headView addSubview:line];
    return headView;
}

-(void) cilckHeaderButton:(UIButton *)sender{
    if (sender.selected) {
        self.wysArray[sender.tag - 1000] = @"0";
    }else{

       self.wysArray[sender.tag - 1000] = @"1";
        
    }
    [self.tableView reloadData];
    
}

#pragma mark - 创建物业公司选择
-(void) setUpWyCompanyView {
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, KWindowWidth, 50)];
    backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backView];
    
    for (int i = 0; i< 2; i++) {
        DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 9.5+50*i, KWindowWidth, 0.5)];
        [self.view addSubview:line];
    }
    
    self.wyLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, KWindowWidth - 110, 49)];
    _wyLab.text = @"物业公司：请选择物业公司";
    self.wyLab.font = [UIFont systemFontOfSize:14];
    self.wyLab.textColor = kTextColor;
    [backView addSubview:self.wyLab];
    
    UIButton *wyBtn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth - 85, 5, 70, 40)];
    wyBtn.layer.borderWidth = 1;
    wyBtn.layer.borderColor = kMainColor.CGColor;
    wyBtn.layer.cornerRadius = 4;
    wyBtn.layer.masksToBounds = YES;
    [wyBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [wyBtn setTitle:@"物业" forState:UIControlStateNormal];
    wyBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [wyBtn addTarget:self action:@selector(clickWyButton) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:wyBtn];
    
}

-(void) clickWyButton {
    __weak typeof(self) weakSelf = self;
    [GoveCkManager getWYOptionListWithSuccess:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        
        CKBaoJingView *backview = [[CKBaoJingView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        backview.titleStr = @"物业公司";
        backview.dataArray = [NSMutableArray arrayWithArray:tempArray];
        [self.view addSubview:backview];
        
        [backview setFinishButtonTitleStr:^(NSString *name){
            NSString *str = [NSString stringWithFormat:@"物业公司：%@",name];
            self.wyLab.text = str;
        }];
        [backview setFinishButtonTitleID:^(NSString *strID){
            self.wyStrId = strID;
            [self loadDataWith:self.wyStrId];
        }];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                [weakSelf.view showActivityWithImage:kLoadingImage];
                [weakSelf clickWyButton];
            }];
        }
    }];
}

-(void) loadDataWith:(NSString *)wyId {
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [GoveCkManager getWYCompanyDetailWithWyID:wyId success:^(id responseObject) {
        self.tableView.hidden = NO;
        
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        
        NSDictionary *model = responseObject[@"wymodel"];
        NSArray *array = responseObject[@"villagelist"];
        NSMutableArray *villArr = [NSMutableArray array];
        NSArray *wysModel = responseObject[@"wystafflist"];
        NSMutableArray *wysArr = [NSMutableArray array];
    
        self.comLab.text = model[@"wyname"];
        self.addLab.text = model[@"address"];
        self.legalLab.text = model[@"legalname"];
        self.phoLab.text = model[@"phone"];
        self.regNo.text = model[@"regNo"];
        self.reportNoLab.text = model[@"reportNo"];
        
        if (array.count > 0) {
            for (NSDictionary *tempDic in array) {
                
                GJAlarmDetailModel *model = [GJAlarmDetailModel new];
                model.wyname = tempDic[@"vname"];
               
                [villArr addObject:model];
            }
        }
        
        if (wysModel.count > 0) {
            for (NSDictionary *tempDic in wysModel) {
                
                GJAlarmDetailModel *model = [GJAlarmDetailModel new];
                model.wyname = tempDic[@"name"];
                [wysArr addObject:model];
            }
        }
        
        self.villageArray = [NSMutableArray arrayWithObjects:villArr,wysArr, nil];
        
        self.wysArray = [NSMutableArray array];
        for (int i = 0; i < self.villageArray.count; i++) {
            
            [self.wysArray addObject:@"0"];
        }
        
        [weakSelf.tableView reloadData];
    } failure:^(NSError *error) {
        [weakSelf.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakSelf.view showHudMessage:error.localizedDescription];
        }else{
            [weakSelf.view showFailedViewReloadBlock:^{
                
                [weakSelf loadDataWith:wyId];
            }];
        }
    }];
}

-(void)chooseBlessingMeg{
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView reloadData];
}

@end
