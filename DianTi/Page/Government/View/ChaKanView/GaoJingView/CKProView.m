//
//  CKProView.m
//  DianTi
//
//  Created by 云彩 on 2017/4/11.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "CKProView.h"
#import "CKProCollectionViewCell.h"
#import "DividingLine.h"
#import "SelectAreaModel.h"
#import "MBProgressHUD.h"

@interface CKProView()<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) UICollectionView *colletionView;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *strId;
@property (nonatomic, strong) MBProgressHUD *hud;

@end

@implementation CKProView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpHeadViewUI];
        
    }
    return self;
}

- (void) setUpHeadViewUI{
    
    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
    backView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:backView];
    backView.alpha = 0.5;
    backView.userInteractionEnabled = YES;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768)];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.cornerRadius = 10;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = 1;
    view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self addSubview:view];
    
    self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake((KWindowWidth - 20)/2.0 - 40, 0, 80, 50)];
    self.titleLab.textColor = kTextColor;
    self.titleLab.font = [UIFont systemFontOfSize:16];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:self.titleLab];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(KWindowWidth-85, 0, 50, 50)];
    [btn setImage:[UIImage imageNamed:@"regist_close"] forState:UIControlStateNormal];
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [view addSubview:btn];
    [btn addTarget:self action:@selector(clickButton) forControlEvents:UIControlEventTouchUpInside];
    
    DividingLine *line = [[DividingLine alloc] initWithFrame:CGRectMake(0, 50, KWindowWidth-20, 0.5)];
    [view addSubview:line];
    
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing=0; //设置每一行的间距
    layout.minimumInteritemSpacing = 0;
    
    self.colletionView=[[UICollectionView alloc]initWithFrame:CGRectMake(5, 65, KWindowWidth - 30, KWindowHeight - 270 * KWindowHeight / 768-160) collectionViewLayout:layout];
    self.colletionView.delegate=self;
    self.colletionView.dataSource=self;
    self.colletionView.showsVerticalScrollIndicator = NO;
    self.colletionView.backgroundColor = [UIColor whiteColor];
    [view addSubview:self.colletionView];
    self.colletionView.layer.cornerRadius = 5;
    self.colletionView.layer.masksToBounds = YES;
    self.colletionView.layer.borderWidth = 1;
    self.colletionView.layer.borderColor = kLineColor.CGColor;
    self.colletionView.frame=CGRectMake(5, 65, KWindowWidth - 30, KWindowHeight - 270 * KWindowHeight / 768-160);
    //注册cell单元格
    [self.colletionView registerClass:[CKProCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(self.colletionView.frame)+40, KWindowWidth - 30, 50)];
    sureBtn.backgroundColor = kMainColor;
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [view addSubview:sureBtn];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    sureBtn.layer.cornerRadius = 5;
    [sureBtn addTarget:self action:@selector(clickSureButton) forControlEvents:UIControlEventTouchUpInside];
}

-(void) clickSureButton {
    NSLog(@"%@",self.name);
    if (self.name.length == 0) {
        MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, KWindowHeight)];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.label.text = @"请选择";
        [HUD showAnimated:YES];
        [HUD hideAnimated:YES afterDelay:1];
        [self addSubview:HUD];
        return;
    }
    [self removeFromSuperview];
    self.finishButtonTitStr(self.name);
    self.finishButtonTitID(self.strId);
}

-(void) clickButton {
    [self removeFromSuperview];
}

#pragma mark - collectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

#pragma mark - collectionViewCell 设置
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    CKProCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = kLineColor;
    
    SelectAreaModel *model = self.dataSource[indexPath.item];
    
    [cell.btn setTitle:model.name forState:UIControlStateNormal];
    [cell.btn addTarget:self action:@selector(cilckCellButton:) forControlEvents:UIControlEventTouchUpInside];
    cell.btn.tag = 1000+indexPath.item;
    return cell;
    
}

-(void) cilckCellButton:(UIButton *)sender {
    
    for (int i = 0; i < self.dataSource.count; i++) {
        if (sender.tag == 1000+i) {
            SelectAreaModel *model = self.dataSource[i];
            sender.selected = YES;
            sender.backgroundColor = kMainColor;
            self.name = model.name;
            self.strId = model.strID;
            continue;
        }
        UIButton *btn = (UIButton *)[self viewWithTag:1000+i];
        btn.selected = NO;
        btn.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark ---- UICollectionViewDelegateFlowLayout
//设置每个 UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.colletionView.frame.size.width)/3.0, 40);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (void)setTitleStr:(NSString *)titleStr{
    self.titleLab.text = titleStr;
}

@end
