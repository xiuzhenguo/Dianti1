//
//  WBDianTiDiantiViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/16.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "WBDianTiDiantiViewController.h"
#import "WBDianTiXiangQingViewController.h"
#import "DividingLine.h"
#import "WBLeftCell.h"

#import "UICollectionView+Refresh.h"
#import "UIImage+Color.h"

#import "PropertyManager.h"
#import "MaintenanceManager.h"

#import "PersonInformation.h"
#import "AreaModel.h"
#import "EvevatorModel.h"

#import "WBXiaoquCollectionViewCell.h"
@interface WBDianTiDiantiViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSMutableArray *itemArray;
}
@property (nonatomic) NSInteger pageNum;

@end

@implementation WBDianTiDiantiViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [mainCollectionView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubView];

    
}

- (void)setupSubView
{

    self.navigationItem.title = @"电梯管理";
    //1.初始化layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //设置collectionView滚动方向
    //    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    //该方法也可以设置itemSize
    layout.itemSize = CGSizeMake(KWindowWidth * 0.25, KWindowWidth * 0.25 + 60);
    
    //2.初始化collectionView
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, KWindowWidth - 30, KWindowHeight - 20 - 44) collectionViewLayout:layout];
    mainCollectionView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[WBXiaoquCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;
    
    
    
    //上拉加载，下拉刷新
    __weak typeof(self) weakSelf = self;
    
    [mainCollectionView addRefreshHeaderBlock:^{
        weakSelf.pageNum  = 1;
        [weakSelf loadData];
    }];
    [mainCollectionView addRefreshFooterBlock:^{
        weakSelf.pageNum++;
        [weakSelf loadData];
    }];

}

- (void)loadData
{
    if (self.area) {
        [self loadDataWith:self.area.areaID];
    }
    [self.view showHudWithActivity:@"正在加载"];
    
}

- (void)loadDataWith:(NSString *)areaID
{
    __weak typeof(self) weakSelf = self;
    [MaintenanceManager getElevatorListWithVid:areaID pageIndex:[NSString stringWithFormat:@"%ld",(long)self.pageNum] pageSize:@"12" success:^(id responseObject) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        NSArray *tempArray = responseObject;
        if(tempArray.count == 0 && weakSelf.pageNum == 1){
            [mainCollectionView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        if(weakSelf.pageNum == 1){
            itemArray = [NSMutableArray arrayWithArray:tempArray];
            if(tempArray.count < 12){
                
                [mainCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
        }else{
            if(tempArray.count < 12){
                
                [mainCollectionView.mj_footer endRefreshingWithNoMoreData];
            }
            [itemArray addObjectsFromArray:tempArray];
        }
        [mainCollectionView reloadData];
        
    } failure:^(NSError *error) {
        [weakSelf chooseBlessingMeg];
        [weakSelf.view hideHubWithActivity];
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
    [mainCollectionView.mj_header endRefreshing];
    [mainCollectionView.mj_footer endRefreshing];
    [mainCollectionView reloadData];
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
    
    WBXiaoquCollectionViewCell *cell = (WBXiaoquCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    
    EvevatorModel *model = itemArray[indexPath.row];
    cell.evevator = model;
    cell.backgroundColor = [UIColor clearColor];
    
    
    
    return cell;
}

//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(KWindowWidth * 0.25, KWindowWidth * 0.25 + 60);
}


//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.01, 0.0, 0.01, 0.0);
}

//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return (KWindowWidth / 4 - 30) / 2;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.01;
}


//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EvevatorModel *model = itemArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    WBDianTiXiangQingViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"WBDianTiXiangQing"];
    vc.evevator = model;
    vc.typestr = self.typeStr;
    [self.navigationController pushViewController:vc animated:YES];
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
