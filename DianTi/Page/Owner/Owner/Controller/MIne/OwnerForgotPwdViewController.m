//
//  OwnerForgotPwdViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/23.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "OwnerForgotPwdViewController.h"
#import "PersonInformation.h"
#import "OwnerManager.h"
#import "DividingLine.h"
@interface OwnerForgotPwdViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UIView *pwd1View;
@property (weak, nonatomic) IBOutlet UIView *pwd2VIew;
@property (weak, nonatomic) IBOutlet UIView *pwd3View;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF1;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF2;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF3;

@end

@implementation OwnerForgotPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setSubview];
    self.navigationItem.title = @"修改密码";
}

- (void)setSubview
{
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line3 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line4 = [[DividingLine alloc] initWithFrame:CGRectMake(0, _pwd3View.height - 0.5, KWindowWidth, 0.5)];
    
    
    [self.pwd1View addSubview:line1];
    [self.pwd2VIew addSubview:line2];
    [self.pwd3View addSubview:line3];
    [self.pwd3View addSubview:line4];
}

- (IBAction)sure:(id)sender {
    
    if (_pwdTF1.text.length > 0 && _pwdTF2.text.length > 0 && _pwdTF3.text.length > 0) {
        if ([_pwdTF3.text isEqualToString:_pwdTF2.text]) {
            [self.view showHudWithActivity:@"正在加载"];
            __weak typeof(self) weakSelf = self;
            [OwnerManager getOwnerInfoWithOID:[PersonInformation sharedPersonInformation].userID oldpwd:self.pwdTF1.text newpwd:self.pwdTF2.text success:^(id responseObject) {
                [weakSelf.view hideHubWithActivity];
                [weakSelf.view showHudWithActivity:@"修改成功"];
                [weakSelf performBlock:^{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                } afterDelay:1];
                
            } failure:^(NSError *error) {
                [weakSelf.view hideHubWithActivity];
                if([error.domain isEqualToString:kErrorDomain]){
                    [weakSelf.view showHudMessage:error.localizedDescription];
                }else{
                    
                    [weakSelf.view showHudMessage:@"网络异常"];
                }
            }];
        }
        else
        {
            [self.view showHudMessage:@"新密码输入不一致"];
        }
    }
    else
    {
        [self.view showHudMessage:@"不能为空"];
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
