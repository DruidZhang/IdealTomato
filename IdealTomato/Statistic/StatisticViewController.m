//
//  StatisticViewController.m
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticViewController.h"
#import "../Timer/TimerViewController.h"
#import "../DBHelper.h"

@interface StatisticViewController()

@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:240.0/255.0 green:240.0/255.0 blue:242.0/255.0 alpha:1]];
    
    CGFloat statusbarHeight = [[UIApplication sharedApplication]statusBarFrame].size.height;
    CGFloat navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    
    UIView *supportLine = [[UIView alloc] initWithFrame:CGRectMake(screenWidth/2-1, 0, 2, [UIScreen mainScreen].bounds.size.height)];
    supportLine.backgroundColor = [UIColor greenColor];
    [self.view addSubview:supportLine];
    
    #pragma mark - 今日总结view
    UILabel *todayTitle = [[UILabel alloc] initWithFrame:CGRectMake(40,statusbarHeight+navigationbarHeight+60, screenWidth-80, 40)];
    [todayTitle setBackgroundColor:[UIColor redColor]];
    todayTitle.font = [UIFont boldSystemFontOfSize:20.0f];
    todayTitle.text = @"今日总结";
    todayTitle.textColor = [UIColor blackColor];
    todayTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:todayTitle];
    
    UILabel *todayCompletedTask = [[UILabel alloc] initWithFrame:CGRectMake(20, statusbarHeight+navigationbarHeight+120, screenWidth/2-40, 40)];
    todayCompletedTask.backgroundColor = [UIColor redColor];
    todayCompletedTask.font = [UIFont systemFontOfSize:18.0f];
//    todayCompletedTask.text = [NSString stringWithFormat:@"已完成任务:%d",[DBHelper getTodayCompletedTaskCount]];
    todayCompletedTask.text = @"已完成任务:2";
    todayCompletedTask.textColor = [UIColor blackColor];
    todayCompletedTask.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:todayCompletedTask];
    
    UILabel *todayGoodTomato = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2+20, statusbarHeight+navigationbarHeight+120, screenWidth/2-40, 40)];
    todayGoodTomato.backgroundColor = [UIColor redColor];
    todayGoodTomato.font = [UIFont systemFontOfSize:18.0f];
//        todayCompletedTask.text = [NSString stringWithFormat:@"收货番茄:%d",[DBHelper getTodayGoodTomatoCount]];
    todayGoodTomato.text = @"收货番茄:1";
    todayGoodTomato.textColor = [UIColor blackColor];
    todayGoodTomato.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:todayGoodTomato];
    
    #pragma mark - dividerView
    UIView *dividerView = [[UIView alloc] initWithFrame:CGRectMake(0, statusbarHeight+navigationbarHeight+180, screenWidth, 2)];
    [dividerView setBackgroundColor:[UIColor blackColor]];
    [self.view addSubview:dividerView];
    #pragma mark - 历史总结view
    UILabel *totalTitle = [[UILabel alloc] initWithFrame:CGRectMake(40, statusbarHeight+navigationbarHeight+200, screenWidth-80, 40)];
    totalTitle.backgroundColor = [UIColor redColor];
    totalTitle.font = [UIFont boldSystemFontOfSize:20.0f];
    totalTitle.text = @"历史总结";
    totalTitle.textColor = [UIColor blackColor];
    totalTitle.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:totalTitle];
    
    UILabel *totalCompletedTask = [[UILabel alloc] initWithFrame:CGRectMake(20, statusbarHeight+navigationbarHeight+260, screenWidth/2-40, 40)];
    totalCompletedTask.backgroundColor = [UIColor redColor];
    totalCompletedTask.font = [UIFont systemFontOfSize:18.0f];
//    totalCompletedTask.text = [NSString stringWithFormat:@"已完成任务:%d",[DBHelper getCompletedTaskCount]];
    totalCompletedTask.text = @"已完成任务:2";
    totalCompletedTask.textColor = [UIColor blackColor];
    totalCompletedTask.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:totalCompletedTask];
    
    UILabel *totalGoodTomato = [[UILabel alloc] initWithFrame:CGRectMake(screenWidth/2+20,statusbarHeight+navigationbarHeight+260, screenWidth/2-40, 40)];
    totalGoodTomato.backgroundColor = [UIColor redColor];
    totalGoodTomato.font = [UIFont systemFontOfSize:18.0f];
//    totalGoodTomato.text = [NSString stringWithFormat:@"收获番茄:%d",[DBHelper getGoodTomatoCount]];
    totalGoodTomato.text = [NSString stringWithFormat:@"收货番茄:1"];
    totalGoodTomato.textColor = [UIColor blackColor];
    totalGoodTomato.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:totalGoodTomato];
}

@end
