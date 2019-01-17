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
#import "../Tomato.h"

@interface TimerViewController()

@property TimerView *timerView;
@property Tomato *tomato;

@end

@implementation TimerViewController



- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)loadView {
    self.tabBarController.tabBar.hidden = YES;
    self.timerView = [[TimerView alloc]init];
    self.view = _timerView;
    self.view.backgroundColor = UIColor.redColor;
}

- (void)drawCircle: (int)angle andDo:(void(^)(id obj))tomatoDone {
    [self.timerView drawCircle:angle];
}

@end
