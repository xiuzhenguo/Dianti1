//
//  NavigationController.m
//  GoftApp
//
//  Created by admin on 15/8/21.
//  Copyright (c) 2015年 mohe. All rights reserved.
//

#import "NavigationController.h"
#import "BaseViewController.h"
#import "UIImage+Color.h"
@interface NavigationController ()
{
    BOOL valid;
    UIPanGestureRecognizer *panRecognizer;
}
@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tabBarItem.selectedImage = [self.tabBarItem.selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    self.tabBarItem.image = [self.tabBarItem.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    
    [self.navigationBar setTranslucent:NO];
    
    panRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(paningGestureReceive:)];
    [panRecognizer delaysTouchesBegan];
    
    [self.view addGestureRecognizer:panRecognizer];
}
- (void)setGestureEnable:(BOOL)enable
{
    [panRecognizer setEnabled:enable];
}
- (BOOL)isRightPan:(CGPoint)translation
{
    if (fabs(translation.x) > 100)
    {
        BOOL gestureHorizontal = NO;
        
        if (translation.y ==0.0)
        {
            gestureHorizontal = YES;
        }
        else
        {
            gestureHorizontal = (fabs(translation.x / translation.y) >5.0);
        }
        
        if (gestureHorizontal)
        {
            if (translation.x >0.0)
                
                return YES;
        }
        
    }
    return NO;
}
- (void)paningGestureReceive:(UIPanGestureRecognizer *)gesture
{
    
    CGPoint translation = [gesture translationInView:self.view];
    if(gesture.state == UIGestureRecognizerStateBegan){
        valid = YES;
    }
    else if (gesture.state == UIGestureRecognizerStateChanged && valid == YES)
        
    {
        
        if( [self isRightPan:translation]){
            BaseViewController *viewController = (BaseViewController *)self.topViewController;
            [viewController  back:nil];
            valid = NO;
        }
        
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
