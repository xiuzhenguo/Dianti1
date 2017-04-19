//
//  WBContentChooseViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/14.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBContentChooseViewController.h"
#import "WBContentCell.h"
#import "DividingLine.h"

#import "MaintenanceManager.h"

#import "AreaModel.h"

@interface WBContentChooseViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSArray *itemArray;
}

@end

@implementation WBContentChooseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setupSubView];
    [self loadData];
}

- (void)setupSubView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //该方法也可以设置itemSize
    layout.itemSize = CGSizeMake((KWindowWidth - 20) / 3, 40);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10, 60, self.view.width - 20, 200) collectionViewLayout:layout];
    mainCollectionView.layer.cornerRadius = 5;
    mainCollectionView.layer.masksToBounds = YES;
    mainCollectionView.layer.borderWidth = 1;
    mainCollectionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[WBContentCell class] forCellWithReuseIdentifier:@"cellId"];
    
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 50, self.view.width, 1)];
    [self.view addSubview:line];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - 100) / 2, 0, 100, 50)];
    titleLabel.text = @"保养内容";
    titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
    [self.view addSubview:titleLabel];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"regist_close"] forState:UIControlStateNormal];
    button.size = CGSizeMake(30, 25);
    button.center = CGPointMake(self.view.width - 40, 25);
    [self.view addSubview:button];
    
    [button addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
    sure.size = CGSizeMake(self.view.width - 20, (KWindowWidth - 60) /  1182 * 171);
    sure.center = CGPointMake(self.view.width / 2, 320);
    [sure setTitle:@"确定" forState:UIControlStateNormal];
    [sure setBackgroundImage:[UIImage imageNamed:@"login_loginBtn_normal"] forState:UIControlStateNormal];
    [self.view addSubview:sure];

    [sure addTarget:self action:@selector(queding) forControlEvents:UIControlEventTouchUpInside];
    
    
    UILabel *duoxuanlabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.width - 60, mainCollectionView.bottom + 10, 50, 20)];
    duoxuanlabel.textAlignment = 2;
    duoxuanlabel.text = @"可多选";
    duoxuanlabel.font = TEXTFONT(12);
    duoxuanlabel.textColor = kMainColor;
    [self.view addSubview:duoxuanlabel];
    
}

- (void)loadData
{
    __weak typeof(self) weakself = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getLiftMaintainListSuccess:^(id responseObject) {
        
        [weakself.view hidFailedView];
        [weakself.view hideHubWithActivity];
        itemArray = responseObject;
        for (AreaModel *model in itemArray) {
            for (AreaModel *model1 in self.array) {
                if ([model.areaID isEqualToString:model1.areaID]) {
                    model.state = @"1";
                }
            }
        }
        [mainCollectionView reloadData];
        
    } failure:^(NSError *error) {
        [weakself.view hideHubWithActivity];
        if([error.domain isEqualToString:kErrorDomain]){
            [weakself.view showHudMessage:error.localizedDescription];
        }else{
            [weakself.view showFailedViewReloadBlock:^{
                
                [weakself loadData];
            }];
        }
    }];
}

#pragma mark collectionView代理方法
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return itemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    WBContentCell *cell = (WBContentCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    AreaModel *model = itemArray[indexPath.row];
    cell.model = model;
    
    if (indexPath.row == (itemArray.count - 1)) {
        DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(cell.contentView.frame.size.width - 1, 0, 1, cell.contentView.frame.size.height)];
        [cell.contentView addSubview:line];
    }
    
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KWindowWidth - 40 - 0) / 3, 40);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.01, 0.0, 0.01, 0.0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.0;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01;
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    AreaModel *model = itemArray[indexPath.row];
    if ([model.state integerValue] == 1) {
        model.state = @"0";
    }
    else
    {
        model.state = @"1";
    }
    
    WBContentCell *cell = (WBContentCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.model = model;
}

#pragma mark - button click
- (void)close{
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    if (self.chooseFinish) {
        self.chooseFinish(nil);
    }
}

- (void)queding {
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
    NSMutableArray *tempArray = [NSMutableArray array];
    if (itemArray.count > 0) {
        for (AreaModel *model in itemArray) {
            if ([model.state integerValue] == 1) {
                [tempArray addObject:model];
            }
        }
    }
    if (self.chooseFinish) {
        self.chooseFinish(tempArray);
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
