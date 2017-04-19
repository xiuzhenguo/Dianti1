//
//  ZhengfuTabbarController.m
//  DianTi
//
//  Created by 佘坦烨 on 17/1/5.
//  Copyright © 2017年 bravedark. All rights reserved.
//

#import "ZhengfuTabbarController.h"

@interface ZhengfuTabbarController ()

@end

@implementation ZhengfuTabbarController

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
    tabBarItem1.selectedImage = [UIImage imageNamed:@"chakanxinxi_select"];
    
    UITabBarItem *tabBarItem2 = [self.tabBar.items objectAtIndex:2];
    tabBarItem2.image = [tabBarItem2.image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem2.selectedImage = [UIImage imageNamed:@"property_wode_selected"];
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
