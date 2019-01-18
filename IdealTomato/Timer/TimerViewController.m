//
//  TimerViewController.m
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerViewController.h"
#import "TimerView.h"

@interface TimerViewController()

@property TimerView *timerView;
@property TaskModel *task;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    self.tabBarController.tabBar.hidden = YES;
    _timerView = [[TimerView alloc]init];
    [self.view addSubview:_timerView];
}

- (void)showTimerWith:(TaskModel *)task andDo:(void (^)(void))tomatoDone{
    self.task = task;
    
}

- (void)drawCircle: (int)angle andDo:(void(^)(id obj))tomatoDone {
    [self.timerView drawCircle:angle];
}

@end
