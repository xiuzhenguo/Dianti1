//
//  OwnerMineViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/20.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerMineViewController.h"
#import "OwnerForgotPwdViewController.h"
#import "OwnerAreaListViewController.h"
#import "OwnerMyRecordViewController.h"
#import "PersonInformation.h"
#import "OwnerManager.h"
#import "OwnerMineCell.h"
#import "DividingLine.h"
#import "LXFileManager.h"
@interface OwnerMineViewController ()
{
    NSArray *itemArray;
    NSArray *item2Array;
}
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (weak, nonatomic) IBOutlet UIButton *quedingBtn;

@end

@implementation OwnerMineViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的";
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *bgimage = [self imageWithImageSimple:[UIImage imageNamed:@"commonbg"] scaledToSize:CGSizeMake(KWindowWidth, KWindowHeight)];
    self.buttonView.backgroundColor = [UIColor colorWithPatternImage:bgimage];
    [self loadData];
}

- (void)loadData
{
    [self.view showHudWithActivity:@"正在加载"];
    itemArray = @[@"修改密码",@"修改所在小区",@"我的报修记录"];
    item2Array = @[[UIImage imageNamed:@"owner_pwd"],[UIImage imageNamed:@"owner_area"],[UIImage imageNamed:@"owner_record"]];
    [self.tableview reloadData];
    __weak typeof(self) weakSelf = self;
    [OwnerManager getOwnerInfoWithOID:[PersonInformation sharedPersonInformation].userID success:^(id responseObject) {
        [weakSelf.view hideHubWithActivity];
        [weakSelf.view hidFailedView];
        weakSelf.nameLabel.text = [NSString stringWithFormat:@"%@",[PersonInformation sharedPersonInformation].user_name];
        weakSelf.phoneLabel.text = [NSString stringWithFormat:@"%@",[PersonInformation sharedPersonInformation].user_phone];
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


#pragma mark - tableviewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  itemArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OwnerMineCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 1, KWindowWidth, 0.5)];
        [cell.contentView addSubview:line1];
    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.photoImage.image = item2Array[indexPath.row];
    cell.titleLB.text = [NSString stringWithFormat:@"%@",itemArray[indexPath.row]];
    
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    switch (indexPath.row) {
        case 0:
        {
            OwnerForgotPwdViewController *forgotVC = [storyboard instantiateViewControllerWithIdentifier:@"OwnerForgotPwd"];
            [self.navigationController pushViewController:forgotVC animated:YES];
        }
            break;
        case 1:
        {
            OwnerAreaListViewController *areaVC = [storyboard instantiateViewControllerWithIdentifier:@"OwnerAreaList"];
            [self.navigationController pushViewController:areaVC animated:YES];
        }
            break;
        case 2:
        {
            OwnerMyRecordViewController *recordVC = [storyboard instantiateViewControllerWithIdentifier:@"OwnerMyRecord"];
            [self.navigationController pushViewController:recordVC animated:YES];
        }
            break;
            
        default:
            break;
    }
}



#pragma mark - button click
- (IBAction)logOut:(id)sender {
    [LXFileManager saveUserData:@"" forKey:kCurrentUserInfo];
    [PersonInformation sharedPersonInformation].user_type = 0;
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext (newSize);
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
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
