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

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    TimerView * timerView = [[TimerView alloc]init];
    self.view = timerView;
}

@end
