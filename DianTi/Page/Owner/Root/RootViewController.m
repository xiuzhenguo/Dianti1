
//
//  RootViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/28.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "RootViewController.h"
#import "PersonInformation.h"
#import "LoginViewController.h"
@interface RootViewController ()

@property (weak, nonatomic) IBOutlet UIButton *yezhuBtn;
@property (weak, nonatomic) IBOutlet UIButton *wuyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *weibaoBtn;
@property (weak, nonatomic) IBOutlet UIButton *zhengfuBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;

@end

@implementation RootViewController

- (void)getEnterView
{
#warning 测试
    [PersonInformation sharedPersonInformation].user_type = @"4";
    UITabBarController *tabBarController;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    switch ([[PersonInformation sharedPersonInformation].user_type integerValue]) {
        case 1:
        {
            tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"OwnerTabBar"];
            [self presentViewController:tabBarController animated:YES completion:^{
                
            }];
        }
            break;
        case 2:
        {
            tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"PropertyTabBar"];
            [self presentViewController:tabBarController animated:YES completion:^{
                
            }];
        }
            break;
        case 3:
        {
            tabBarController = [storyboard instantiateViewControllerWithIdentifier:@"MaintenanceTabBar"];
            [self presentViewController:tabBarController animated:YES completion:^{
                
            }];
        }
            break;
            
        default:
            break;
    }
}

- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext (newSize);
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([AppUnit sharedInstance].isLogin) {
        [self getEnterView];
    }
    
    [self setupSubViews];
}

- (void)setupSubViews
{
    if (KWindowWidth == 320) {
        _leftDistance.constant = 45;
        _rightDistance.constant = 45;
    }
    if (KWindowWidth == 375) {
        _leftDistance.constant = 55;
        _rightDistance.constant = 55;
    }
    
    UIImage *bgimage = [self imageWithImageSimple:[UIImage imageNamed:@"root_bg"] scaledToSize:CGSizeMake(KWindowWidth, KWindowHeight)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgimage];
    
    UIView *statebackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 20)];
    statebackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:statebackView];
    
    [_yezhuBtn setImage:[UIImage imageNamed:@"root_yezhu_highlighted"] forState:UIControlStateHighlighted];
    [_wuyeBtn setImage:[UIImage imageNamed:@"root_wuye_highlighted"] forState:UIControlStateHighlighted];
    [_weibaoBtn setImage:[UIImage imageNamed:@"root_weibao_highlighted"] forState:UIControlStateHighlighted];
    [_zhengfuBtn setImage:[UIImage imageNamed:@"root_zhengfu_highlighted"] forState:UIControlStateHighlighted];
    
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
    LoginViewController *loginVC = [segue destinationViewController];
    if ([segue.identifier isEqualToString:@"yezhu"]) {
        loginVC.type = @"1";
    }
    if ([segue.identifier isEqualToString:@"wuye"]) {
        loginVC.type = @"2";
    }
    if ([segue.identifier isEqualToString:@"weibao"]) {
        loginVC.type = @"3";
    }
    if ([segue.identifier isEqualToString:@"zhengfu"]) {
        loginVC.type = @"4";
    }
}


@end
