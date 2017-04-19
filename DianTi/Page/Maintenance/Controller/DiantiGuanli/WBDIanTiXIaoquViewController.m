//
//  WBDIanTiXIaoquViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/31.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "WBDIanTiXIaoquViewController.h"
#import "WBDianTiDiantiViewController.h"
#import "PersonInformation.h"
#import "WBXiaoquCollectionViewCell.h"
#import "DividingLine.h"
#import "MaintenanceManager.h"
#import "AreaModel.h"
#import "UITabBar+Badge.h"
@interface WBDIanTiXIaoquViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    UICollectionView *mainCollectionView;
    NSArray *itemArray;
}

@end

@implementation WBDIanTiXIaoquViewController

- (void)getTongzhiCount
{
    __weak typeof(self) weakSelf = self;
    [MaintenanceManager getTongzhiCountWithWbid:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        NSInteger count = [responseObject[@"count"] integerValue];
        if (count > 0) {
            [weakSelf.tabBarController.tabBar showBadgeOnItemIndex:3 badge:count];
        }
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [self getTongzhiCount];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getTongzhiCount) name:ENotificationEnterForeground object:nil];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubView];
    [self loadData];
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
    mainCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(15, 0, KWindowWidth - 30, KWindowHeight - 20 - 44 - 44) collectionViewLayout:layout];
//    mainCollectionView.layer.cornerRadius = 5;
//    mainCollectionView.layer.masksToBounds = YES;
//    mainCollectionView.layer.borderWidth = 1;
//    mainCollectionView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [self.view addSubview:mainCollectionView];
    mainCollectionView.backgroundColor = [UIColor clearColor];
    
    //3.注册collectionViewCell
    //注意，此处的ReuseIdentifier 必须和 cellForItemAtIndexPath 方法中 一致 均为 cellId
    [mainCollectionView registerClass:[WBXiaoquCollectionViewCell class] forCellWithReuseIdentifier:@"cellId"];
    
    
    //4.设置代理
    mainCollectionView.delegate = self;
    mainCollectionView.dataSource = self;

}

- (void)loadData
{
    __weak typeof(self) weakSelf = self;
    [self.view showHudWithActivity:@"正在加载"];
    [MaintenanceManager getAreaWithWBID:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        [weakSelf.view hidEmptyDataView];
        [weakSelf.view hidFailedView];
        [weakSelf.view hideHubWithActivity];
        itemArray = responseObject;
        if (itemArray.count > 0) {
            [mainCollectionView reloadData];
        }
        else
        {
            [mainCollectionView showEmptyDataViewWitlTitle:@"没有数据" actionTitle:nil actionBlock:nil];
        }
        
    } failure:^(NSError *error) {
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
    
    AreaModel *model = itemArray[indexPath.row];
    cell.model = model;
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
    
    WBXiaoquCollectionViewCell *cell = (WBXiaoquCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.photoImageV.image = [UIImage imageNamed:@"xiaoqu_click"];
    AreaModel *model = itemArray[indexPath.row];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];

    WBDianTiDiantiViewController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"WBDianTiDianti"];
    vc1.area = model;
    [self.navigationController pushViewController:vc1 animated:YES];
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
