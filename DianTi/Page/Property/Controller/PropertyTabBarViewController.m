//
//  PropertyTabBarViewController.m
//  DianTi
//
//  Created by 佘坦烨 on 16/12/3.
//  Copyright © 2016年 bravedark. All rights reserved.
//

#import "PropertyTabBarViewController.h"
#import "PropertyManager.h"
@interface PropertyTabBarViewController ()

@end

@implementation PropertyTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    for (UIBarItem *item in self.tabBar.items) {
        [item setImageInsets:UIEdgeInsetsMake(-2, 0, 2, 0)];
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont systemFontOfSize:12], NSFontAttributeName, nil]
                            forState:UIControlStateNormal];
        
    }
    
    self.tabBar.tintColor = kMainColor;

    UITabBarItem *tabBarItem0 = [self.tabBar.items objectAtIndex:0];
    tabBarItem0.selectedImage = [UIImage imageNamed:@"property_zhuye_selected"];
    
    UITabBarItem *tabBarItem1 = [self.tabBar.items objectAtIndex:1];
    tabBarItem1.image = [tabBarItem1.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem1.selectedImage = [UIImage imageNamed:@"property_gaojing_selected"];
    
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:2];
    tabBarItem2.image = [tabBarItem2.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.selectedImage = [UIImage imageNamed:@"weibao_diantiguanli_select"];
    
    UITabBarItem *tabBarItem3 = [self.tabBar.items objectAtIndex:3];
    tabBarItem3.image = [tabBarItem3.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem3.selectedImage = [UIImage imageNamed:@"property_baoxiu_selected"];
    
    UITabBarItem *tabBarItem4 = [self.tabBar.items objectAtIndex:4];
    tabBarItem4.image = [tabBarItem4.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem4.selectedImage = [UIImage imageNamed:@"property_wode_selected"];
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
