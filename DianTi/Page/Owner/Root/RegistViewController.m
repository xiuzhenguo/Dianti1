//
//  RegistViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/11/28.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "RegistViewController.h"
#import "DividingLine.h"
#import "RegistAreaListViewController.h"
#import "UIImage+Color.h"
#import "MZTimerLabel.h"
@interface RegistViewController ()
{
    UIButton *_sendCode;
    MZTimerLabel *reTimeLable;
}
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *pwdView;
@property (weak, nonatomic) IBOutlet UIView *secondPwdView;
@property (weak, nonatomic) IBOutlet UIView *areaView;

@property (weak, nonatomic) IBOutlet UITextField *nameTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTF;
@property (weak, nonatomic) IBOutlet UITextField *secondPwdTF;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomDistance;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightDistance;

@end

@implementation RegistViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupSubViews];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setupSubViews];
}

- (void)setupSubViews
{
    self.title = @"注册";
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
    addArea.frame = CGRectMake(KWindowWidth - 100, 3, 96, self.areaView.height - 4);
    addArea.layer.cornerRadius = 6;
    addArea.layer.masksToBounds = YES;
    [self.areaView addSubview:addArea];
    [addArea addTarget:self action:@selector(addArea) forControlEvents:UIControlEventTouchUpInside];
    
    
    if (KWindowWidth == 320) {
        _bottomDistance.constant = _bottomDistance.constant + 5;
    }
    if (KWindowWidth == 375) {
        _bottomDistance.constant = _bottomDistance.constant + 35;
        addArea.frame = CGRectMake(KWindowWidth - 120, 3, 116, self.areaView.height - 4);
        _sendCode.frame = CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4);
        [reTimeLable setFrame:CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4)];
        _rightDistance.constant -= 20;
    }
    if (KWindowWidth == 414) {
        _bottomDistance.constant = _bottomDistance.constant + 55;
        addArea.frame = CGRectMake(KWindowWidth - 120, 3, 116, self.areaView.height - 4);
        _sendCode.frame = CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4);
        [reTimeLable setFrame:CGRectMake(KWindowWidth - 120, 4, 116, self.codeView.height - 4)];
        _rightDistance.constant -= 20;
    }

    
    DividingLine *line1 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 2)];
    DividingLine *line2 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 2)];
    DividingLine *line3 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 2)];
    DividingLine *line4 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 2)];
    DividingLine *line5 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 2)];
    DividingLine *line6 = [[DividingLine alloc] initWithFrame:CGRectMake(0, 0, KWindowWidth, 2)];
    DividingLine *line7 = [[DividingLine alloc] initWithFrame:CGRectMake(0, self.areaView.height, KWindowWidth, 2)];
    
    [self.nameView addSubview:line1];
    [self.phoneView addSubview:line2];
    [self.codeView addSubview:line3];
    [self.pwdView addSubview:line4];
    [self.secondPwdView addSubview:line5];
    [self.areaView addSubview:line6];
    [self.areaView addSubview:line7];
    
}

- (void)sendCode
{
    [_sendCode removeFromSuperview];
    [self.codeView addSubview:reTimeLable];
    [reTimeLable setCountDownTime:60];
    [reTimeLable start];
}

- (void)addArea
{
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, -64, KWindowWidth, KWindowHeight)];
    bgview.backgroundColor = [UIColor lightGrayColor];
    bgview.alpha = 0.5;
    [self.view addSubview:bgview];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    RegistAreaListViewController *areaList = [storyboard instantiateViewControllerWithIdentifier:@"RegistAreaList"];
    areaList.view.frame = CGRectMake(10, 70, KWindowWidth - 20, KWindowHeight - 270 * KWindowHeight / 768);
    areaList.view.layer.cornerRadius = 10;
    areaList.view.layer.masksToBounds = YES;
    areaList.view.layer.borderWidth = 1;
    areaList.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    areaList.view.backgroundColor = [UIColor whiteColor];
    
    areaList.chooseFinish = ^(NSArray *array){
        if (array == nil || array.count == 0) {
            
        }
        else
        {
            NSMutableString *tempStr = [NSMutableString string];
            for (NSString *str in array) {
                [tempStr appendFormat:@"%@,",str];
            }
            [tempStr deleteCharactersInRange:NSMakeRange(tempStr.length - 1, 1)];
            self.areaLabel.text = tempStr;
        }
        [bgview removeFromSuperview];
    };
    
    [self addChildViewController:areaList];
    [self.view addSubview:areaList.view];
}

- (IBAction)regestClick:(id)sender {

    
    
    

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
