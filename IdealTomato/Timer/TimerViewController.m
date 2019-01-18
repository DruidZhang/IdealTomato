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
@property NSTimer *timer;
@property int workTime;
@property int restTime;


@end

@implementation TimerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
//        _countDownTime = 25*60;
//        _restTime = 5*60;
        _workTime = 10;
        _restTime = 5;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.redColor;
    self.tabBarController.tabBar.hidden = YES;
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(timerCountDown) userInfo:nil repeats:YES];
    //block方式创建timer
//    __weak __typeof(self)weakSelf = self;
//    _timer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"time: %d",self.countDownTime);
//        weakSelf.countDownTime--;
//        if(weakSelf.countDownTime == -1){
//            NSLog(@"stop timer");
//            weakSelf.countDownTime = 5*60;
//            [weakSelf.timer invalidate];
//        }
//    }];
    _timerView = [[TimerView alloc]init];
    [self.view addSubview:_timerView];
    
    [self testShowTimer];
    
}

- (void)timerCountDown{
    NSLog(@"work time: %d",self.workTime);
    
    if(_workTime-- >= 0){
        NSLog(@"draw work circle angle: %d",_workTime+1);
        //draw work circle
    } else {
        NSLog(@"work time end");
        NSLog(@"rest time: %d",_restTime);
    
        if(_restTime-- < 0){
            NSLog(@"rest time end");
            NSLog(@"timer end");
            [_timer invalidate];
        } else {
            NSLog(@"draw rest circle angle: %d",_restTime+1);
        }
    }

//    _workTime--;
//    if(_workTime <0){
//        NSLog(@"rest time: %d",self.restTime);
//        _restTime--;
//        if(_restTime == -1){
//            NSLog(@"stop work timer then start rest timer");
//            [_timer invalidate];
//        }
//    }
}

- (void)testShowTimer {
    //加入循环池
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    //开始循环
    [_timer fire];
}

- (void)showTimerWith:(TaskModel *)task andDo:(void (^)(void))tomatoDone{
    self.task = task;
    //加入循环池
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    //开始循环
    _workTime = 25*60;
    [_timer fire];
}

- (void)drawCircle: (int)angle {
    [self.timerView drawCircle:angle];
}

@end
