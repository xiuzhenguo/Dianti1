//
//  ILSMLAlertView.m
//  MoreLikers
//
//  Created by xiekw on 13-9-9.
//  Copyright (c) 2013年 谢凯伟. All rights reserved.
//

#import "DXAlertView.h"
#import <QuartzCore/QuartzCore.h>

#define kContentColor [UIColor blackColor]

#define kLeftColor [UIColor darkGrayColor]
#define kRightColor kMainColor

#define kAlertWidth ([UIScreen mainScreen].bounds.size.width-60.0f)
#define kAlertHeight 140.0f
@interface DXAlertView ()
{
    BOOL _leftLeave;
}

@property (nonatomic, strong) UILabel *alertContentLabel;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *backImageView;

@end

@implementation DXAlertView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithContentText:(NSString *)content
    leftButtonTitle:(NSString *)leftTitle
   rightButtonTitle:(NSString *)rigthTitle
{
    if (self = [super init]) {
        self.layer.cornerRadius = 5;
        self.backgroundColor = [UIColor whiteColor];
        
        CGFloat contentLabelWidth = kAlertWidth - 16;
        self.alertContentLabel = [[UILabel alloc] initWithFrame:CGRectMake((kAlertWidth - contentLabelWidth) * 0.5, 0, contentLabelWidth, 90)];
        self.alertContentLabel.numberOfLines = 0;
        self.alertContentLabel.textAlignment = NSTextAlignmentCenter;
        self.alertContentLabel.textColor = kContentColor;
        self.alertContentLabel.font = [UIFont systemFontOfSize:16.0f];
        [self addSubview:self.alertContentLabel];
        
        CGRect leftBtnFrame;
        CGRect rightBtnFrame;
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.alertContentLabel.frame), kAlertWidth, 1)];
        [line setBackgroundColor:[UIColor colorWithWhite:230.0f/255.0f alpha:1]];
        [self addSubview:line];
#define kSingleButtonWidth kAlertWidth
#define kCoupleButtonWidth kAlertWidth/2.0f
#define kButtonHeight 50.0f
        if (!leftTitle) {
            rightBtnFrame = CGRectMake((kAlertWidth - kSingleButtonWidth) * 0.5, CGRectGetMaxY(self.alertContentLabel.frame), kSingleButtonWidth, kButtonHeight);
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn.frame = rightBtnFrame;
            
        }else {
            leftBtnFrame = CGRectMake((kAlertWidth - 2 * kCoupleButtonWidth) * 0.5, CGRectGetMaxY(self.alertContentLabel.frame), kCoupleButtonWidth, kButtonHeight);
            rightBtnFrame = CGRectMake(CGRectGetMaxX(leftBtnFrame), CGRectGetMaxY(self.alertContentLabel.frame), kCoupleButtonWidth, kButtonHeight);
            self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            self.leftBtn.frame = leftBtnFrame;
            self.rightBtn.frame = rightBtnFrame;
            UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(kCoupleButtonWidth, CGRectGetMaxY(self.alertContentLabel.frame), 1, kButtonHeight)];
            [line1 setBackgroundColor:[UIColor colorWithWhite:230.0f/255.0f alpha:1]];
            [self addSubview:line1];

        }
        
        [self.rightBtn setTitle:rigthTitle forState:UIControlStateNormal];
        [self.leftBtn setTitle:leftTitle forState:UIControlStateNormal];
        self.leftBtn.titleLabel.font = self.rightBtn.titleLabel.font = [UIFont systemFontOfSize:16];
        [self.leftBtn setTitleColor:kLeftColor forState:UIControlStateNormal];
        [self.rightBtn setTitleColor:kRightColor forState:UIControlStateNormal];
        
        [self.leftBtn addTarget:self action:@selector(leftBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [self.rightBtn addTarget:self action:@selector(rightBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        self.leftBtn.layer.masksToBounds = self.rightBtn.layer.masksToBounds = YES;
        self.leftBtn.layer.cornerRadius = self.rightBtn.layer.cornerRadius = 3.0;
        [self addSubview:self.leftBtn];
        [self addSubview:self.rightBtn];
    
        self.alertContentLabel.text = content;
        
        self.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin;
    }
    return self;
}

- (void)leftBtnClicked:(id)sender
{
    _leftLeave = YES;
    [self dismissAlert];
    if (self.leftBlock) {
        self.leftBlock();
    }
}

- (void)rightBtnClicked:(id)sender
{
    _leftLeave = NO;
    [self dismissAlert];
    if (self.rightBlock) {
        self.rightBlock();
    }
}

- (void)show
{
    UIViewController *topVC = [self appRootViewController];
    self.frame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, - kAlertHeight - 30, kAlertWidth, kAlertHeight);
    self.tag = 19921123;
    for (UIView *item in topVC.view.subviews) {
        if (item.tag == 19921123) {
            [item removeFromSuperview];
        }
    }
    [topVC.view addSubview:self];
}

- (void)dismissAlert
{
    [self removeFromSuperview];
    if (self.dismissBlock) {
        self.dismissBlock();
    }
}

- (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


- (void)removeFromSuperview
{
    UIViewController *topVC = [self appRootViewController];
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, CGRectGetHeight(topVC.view.bounds), kAlertWidth, kAlertHeight);
    
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.frame = afterFrame;
//        if (_leftLeave) {
//            self.transform = CGAffineTransformMakeRotation(-M_1_PI / 1.5);
//        }else {
//            self.transform = CGAffineTransformMakeRotation(M_1_PI / 1.5);
//        }
        self.backImageView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [self.backImageView removeFromSuperview];
        self.backImageView = nil;
        [super removeFromSuperview];
    }];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (newSuperview == nil) {
        return;
    }
    UIViewController *topVC = [self appRootViewController];

    if (!self.backImageView) {
        self.backImageView = [[UIView alloc] initWithFrame:topVC.view.bounds];
        self.backImageView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        self.backImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    [topVC.view addSubview:self.backImageView];
    //self.transform = CGAffineTransformMakeRotation(-M_1_PI / 2);
    CGRect afterFrame = CGRectMake((CGRectGetWidth(topVC.view.bounds) - kAlertWidth) * 0.5, (CGRectGetHeight(topVC.view.bounds) - kAlertHeight) * 0.5, kAlertWidth, kAlertHeight);
    self.backImageView.alpha = 0.0f;
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseIn animations:^{
     //   self.transform = CGAffineTransformMakeRotation(0);
        self.frame = afterFrame;
        self.backImageView.alpha = 1.0f;
    } completion:^(BOOL finished) {
    }];
    [super willMoveToSuperview:newSuperview];
}


@end
