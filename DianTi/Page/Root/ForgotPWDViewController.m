//
//  ForgotPWDViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/28.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "ForgotPWDViewController.h"
#import "DividingLine.h"
#import "UIImage+Color.h"
#import "MZTimerLabel.h"
#import "NSString+Extension.h"
#import "LoginManager.h"
#import "AreaModel.h"
@interface ForgotPWDViewController ()
{
    UIButton *_sendCode;
    MZTimerLabel *reTimeLable;
    NSString *areaCopy;
    NSArray *areaArrayCopy;
}

@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *secondPwdView;


@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *secondPwdTF;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;

@end

@implementation ForgotPWDViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupSubViews];
}

- (void)setupSubViews
{
    self.title = @"忘记密码";
    _sendCode = [UIButton buttonWithType:UIButtonTypeCustom];
    _sendCode.titleLabel.font = TEXTFONT(14);
    [_sendCode setTitle:@"发送验证码" forState:UIControlStateNormal];
    [_sendCode setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendCode setBackgroundImage:[UIImage createImageWithColor:kMainColor] forState:UIControlStateNormal];
    _sendCode.frame = CGRectMake(KWindowWidth - 100, 4, 96, self.codeView.height - 4);
    _sendCode.layer.cornerRadius = 6;
    _sendCode.layer.masksToBounds = YES;
    [self.codeView addSubview:_sendCode];
    [_sendCode addTarget:self action:@selector(sendCode) forControlEvents:UIControlEventTouchUpInside];
    
    reTimeLable = [[MZTimerLabel alloc]initWithTimerType:MZTimerLabelTypeTimer];
    [reTimeLable setTimeFormat:@"mm:ss"];
    [reTimeLable startWithEndingBlock:^(NSTimeInterval countTime)
     {
         [reTimeLable removeFromSuperview];
         [self.codeView addSubview:_sendCode];
     }];
    [reTimeLable setFrame:CGRectMake(KWindowWidth - 100, 4, 96, self.codeView.height - 4)];
    reTimeLable.backgroundColor = kMainColor;
    [reTimeLable.layer setCornerRadius:6];
    reTimeLable.layer.masksToBounds = YES;
    [reTimeLable setFont:[UIFont systemFontOfSize:14]];
    reTimeLable.textColor = [UIColor whiteColor];
    [reTimeLable setTextAlignment:NSTextAlignmentCenter];
    [reTimeLable setNumberOfLines:0];
    [reTimeLable.layer setBorderWidth:1];
    [reTimeLable.layer setBorderColor:[UIColor blueColor].CGColor];
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:reTimeLable.text];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:NSMakeRange(reTimeLable.text.length-2, 2)];
    [reTimeLable setAttributedText:attributedString];
    
    
    UIButton *addArea = [UIButton buttonWithType:UIButtonTypeCustom];
    addArea.titleLabel.font = TEXTFONT(14);
    [addArea setTitle:@"添加小区" forState:UIControlStateNormal];
    [addArea setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [addArea setBackgroundImage:[UIImage createImageWithColor:kMainColor] forState:UIControlStateNormal];
    
    
    
    if (KWindowWidth == 320) {
        _bottomDistance.constant = _bottomDistance.constant + 5;
    }
    if (KWindowWidth == 375) {
        _bottomDistance.constant = _bottomDistance.constant + 35;

        _sendCode.frame = CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4);
        [reTimeLable setFrame:CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4)];

    }
    if (KWindowWidth == 414) {
        _bottomDistance.constant = _bottomDistance.constant + 55;

        _sendCode.frame = CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4);
        [reTimeLable setFrame:CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4)];

    }
    
    

    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line3 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line4 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line5 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 0.5)];
    DividingLine *line6 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.pwdView.height, KWindowWidth, 0.5)];

    [self.phoneView addSubview:line2];
    [self.codeView addSubview:line3];
    [self.pwdView addSubview:line4];
    [self.secondPwdView addSubview:line5];
    [self.secondPwdView addSubview:line6];

    
}

- (void)sendCode
{
    if ([_phoneTF.text checkPhoneNumInput]) {
        __weak typeof(self) weakself = self;
        [LoginManager sendForgotCodewithPhone:_phoneTF.text sucess:^(id responseObject) {
            [_sendCode removeFromSuperview];
            [weakself.codeView addSubview:reTimeLable];
            [reTimeLable setCountDownTime:60];
            [reTimeLable start];
        } failure:^(NSError *error) {
            if([error.domain isEqualToString:kErrorDomain]){
                [weakself.view showHudMessage:error.localizedDescription];
            }else{
                [weakself.view showHudMessage:@"网络异常"];
            }
        }];
    }
    else
    {
        [self.view showHudMessage:@"请检查手机号码"];
    }
    
}
- (IBAction)sure:(id)sender {
    if (self.phoneTF.text.length == 0 || self.codeTF.text.length == 0 || self.pwdTF.text.length == 0 || self.secondPwdTF.text.length == 0) {
        [self.view showHudMessage:@"请输入完整信息"];
        return;
    }
    if (![self.pwdTF.text checKPasswordInput] || ![self.secondPwdTF.text checKPasswordInput]) {
        [self.view showHudMessage:@"密码为6到12位的数字或字母"];
        return;
    }

    if ([self.pwdTF.text isEqual:self.secondPwdTF.text]) {
        
        [self.view showHudWithActivity:@"正在加载"];
        __weak typeof(self) weakself = self;
        
        [LoginManager lookPwdWithPhone:self.phoneTF.text code:self.codeTF.text pwd:self.pwdTF.text success:^(id responseObject) {
            [weakself.view hideHubWithActivity];
            [weakself.view showHudMessage:@"修改成功"];
            [weakself performBlock:^{
                [weakself.navigationController popViewControllerAnimated:YES];
            } afterDelay:1.5];
            
        } failure:^(NSError *error) {
            
            [weakself.view hideHubWithActivity];
            if([error.domain isEqualToString:kErrorDomain]){
                [weakself.view showHudMessage:error.localizedDescription];
            }else{
                [weakself.view showHudMessage:@"网络异常"];
            }
            
        }];
    }
    else
    {
        [self.view showHudMessage:@"两次密码输入不一样"];
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
