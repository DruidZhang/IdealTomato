//
//  MainViewController.m
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MainViewController.h"
#import "../Timer/TimerViewController.h"

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //#f0f0f2
    self.view.backgroundColor = [UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:242.0/255.0 alpha:1];
    //这个是设置view会不会延伸到屏幕上下部分
//    self.edgesForExtendedLayout = UIRectEdgeTop;
    
    //跳转这么写
//    TimerViewController *timerVC = [[TimerViewController alloc]init];
//    [self.navigationController pushViewController:timerVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = NO;
}

@end
