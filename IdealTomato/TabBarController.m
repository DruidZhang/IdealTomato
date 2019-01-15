//
//  TabBarController.m
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import "TabBarController.h"
#import "Task/MainViewController.h"
#import "Statistic/StatisticViewController.h"

@implementation TabBarController

- (void)viewDidLoad{
    [super viewDidLoad];
    [self addChildVC:[[MainViewController alloc]init] title:@"任务" image:@"arrow" selectedImage:@"arrow"];
    [self addChildVC:[[ StatisticViewController alloc]init] title:@"统计" image:@"arrow" selectedImage:@"arrow"];
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    childVC.title = title;
    childVC.tabBarItem.image = [UIImage imageNamed:image];
    childVC.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    //wrap childVC in UINavigationViewController
    UINavigationController *navigationVC = [[UINavigationController alloc]initWithRootViewController:childVC];
    [self addChildViewController:navigationVC];
}

@end
