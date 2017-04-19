//
//  BaseViewController.m
//  Huodi
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 mohekeji. All rights reserved.
//

#import "BaseViewController.h"
#import "LXFileManager.h"
#import "UIImage+Color.h"
@implementation BaseViewController

- (void)showTabBar

{
    if (self.tabBarController.tabBar.hidden == NO)
    {
        return;
    }
    UIView *contentView;
    if ([[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]])
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    
    else
        
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x, contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height - self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)hideTabBar {
    if (self.tabBarController.tabBar.hidden == YES) {
        return;
    }
    UIView *contentView;
    if ( [[self.tabBarController.view.subviews objectAtIndex:0] isKindOfClass:[UITabBar class]] )
        contentView = [self.tabBarController.view.subviews objectAtIndex:1];
    else
        contentView = [self.tabBarController.view.subviews objectAtIndex:0];
    contentView.frame = CGRectMake(contentView.bounds.origin.x,  contentView.bounds.origin.y,  contentView.bounds.size.width, contentView.bounds.size.height + self.tabBarController.tabBar.frame.size.height);
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UINavigationController *nav = (UINavigationController *)self.tabBarController.selectedViewController;
    if (nav.viewControllers[0] == self) {
        [self showTabBar];
    }
    else
    {
        [self hideTabBar];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext (newSize);
    
    [image drawInRect : CGRectMake ( 0 , 0 ,newSize. width ,newSize. height )];
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext ();
    
    UIGraphicsEndImageContext ();
    
    return newImage;
    
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setBackBarButtomItem];
    [self setNavTitleAttributes];
    
    UIImage *bgimage = [self imageWithImageSimple:[UIImage imageNamed:@"commonbg"] scaledToSize:CGSizeMake(KWindowWidth, KWindowHeight)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:bgimage];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage createImageWithColor:kMainColor] forBarMetrics:UIBarMetricsDefault];
    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
    statusBarView.backgroundColor = [UIColor blackColor];
    [self.navigationController.navigationBar addSubview:statusBarView];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    
}

- (void)setNavTitleAttributes
{
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName,[UIFont systemFontOfSize:18.0f],NSFontAttributeName, nil];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

- (void)setBackBarButtomItem{

    if(self.navigationController.viewControllers[0] != self){
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"nav_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back:)];
        UIBarButtonItem *negativeSeperator = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSeperator.width = -6;//此处
        self.navigationItem.leftBarButtonItems = @[negativeSeperator, item];
    }
}
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
