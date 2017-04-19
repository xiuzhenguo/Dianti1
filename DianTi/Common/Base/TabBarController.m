//
//  TabBarController.m
//  Huodi
//
//  Created by admin on 15/12/31.
//  Copyright © 2015年 mohekeji. All rights reserved.
//

#import "TabBarController.h"


@interface TabBarController ()<UITabBarDelegate>

@end

@implementation TabBarController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    for (UIBarItem *item in self.tabBar.items) {
        [item setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont systemFontOfSize:12], NSFontAttributeName, nil]
                            forState:UIControlStateNormal];
        
    }
    

    
    self.tabBar.tintColor = kMainColor;

    
    UITabBarItem *tabBarItem0 = [self.tabBar.items objectAtIndex:0];
    tabBarItem0.selectedImage = [UIImage imageNamed:@"tab_home_selected"];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:1];
    tabBarItem1.image = [tabBarItem1.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarItem1.selectedImage = [UIImage imageNamed:@"tab_hang_selected"];
    
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:2];
    tabBarItem2.image = [tabBarItem2.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    tabBarItem2.selectedImage = [UIImage imageNamed:@"tab_mine_selected"];
    
}



@end
