//
//  LoginViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/28.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginManager.h"
#import "PersonInformation.h"
#import "LXFileManager.h"
#import "DividingLine.h"
@interface LoginViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet UIView *userNameView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UILabel *showLabel;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;

@end

@implementation LoginViewController


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)setupSubViews
{
    self.title = @"登录";
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, self.userNameView.width, 1)];
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.userNameView.height, self.userNameView.width, 1)];
    [self.userNameView addSubview:line1];
    [self.userNameView addSubview:line2];
    DividingLine *line3 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.pwdView.height, self.userNameView.width, 1)];
    [self.pwdView addSubview:line3];
    
    self.showLabel.alpha = 0;
    if ([self.type integerValue] != 1) {
        [self.registBtn removeFromSuperview];
        [self.forgotBtn removeFromSuperview];

    }
    else
    {
        self.userNameTF.placeholder = @"请输入手机号";
    }
    
}

- (IBAction)loginClick:(id)sender {
    __weak typeof(self) weakself = self;
    if (self.userNameTF.text.length == 0 || self.pwdTF.text.length == 0) {
        self.showLabel.text = @"请输入用户名和密码";
        self.showLabel.alpha = 1;
        [self performBlock:^{
            weakself.showLabel.alpha = 0;
        } afterDelay:1];
    }
    else
    {
        [self.view showHudWithActivity:@"正在加载"];
        __weak typeof(self) weakself = self;
        [LoginManager loginWithUsername:self.userNameTF.text userpwd:self.pwdTF.text type:self.type sucess:^(id responseObject)
        {
            [weakself.view hideHubWithActivity];
            UITabBarController *tabBarController;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
            switch ([[PersonInformation sharedPersonInformation].user_type integerValue]) {
                case 1:
                {
                    tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"OwnerTabBar"];
                    [weakself presentViewController:tabBarController animated:YES completion:^{
                        
                    }];
                }
                    break;
                case 2:
                {
                    tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"PropertyTabBar"];
                    [weakself presentViewController:tabBarController animated:YES completion:^{
                        
                    }];
                    
                }
                    break;
                case 3:
                {
                    tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"MaintenanceTabBar"];
                    [weakself presentViewController:tabBarController animated:YES completion:^{
                        
                    }];
                }
                    break;
                case 4:
                {
                    tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"ZhengfuTabBar"];
                    [weakself presentViewController:tabBarController animated:YES completion:^{
                        
                    }];
                }
                    break;
                    
                    
                default:
                    break;
            }

        } failure:^(NSError *error) {

            [weakself.view hideHubWithActivity];
            if([error.domain isEqualToString:kErrorDomain]){
                weakself.showLabel.text = error.localizedDescription;
                weakself.showLabel.alpha = 1;
                [weakself performBlock:^{
                    weakself.showLabel.alpha = 0;
                } afterDelay:1];
            }else{
                weakself.showLabel.text = @"网络异常";
                weakself.showLabel.alpha = 1;
                [weakself performBlock:^{
                    weakself.showLabel.alpha = 0;
                } afterDelay:1];
            }
            
        }];
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
