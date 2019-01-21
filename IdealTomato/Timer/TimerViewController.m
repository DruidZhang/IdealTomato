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

@property const int a;

@property TimerView *timerView;
@property TaskModel *task;
@property NSTimer *timer;
@property int workTime;
@property int restTime;


@end

static int WORK_TIME = 10;
static int REST_TIME = 5;

@implementation TimerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _workTime = WORK_TIME;
        _restTime = REST_TIME;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
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
    //状态栏高度
    int statusbarHeight = [[UIApplication sharedApplication]statusBarFrame].size.height;
    //导航栏高度
    int navigationbarHeight = self.navigationController.navigationBar.frame.size.height;
    //屏幕宽度
    int screenWidth = [UIScreen mainScreen].bounds.size.width;
    _timerView = [[TimerView alloc]initWithFrame:CGRectMake(40, statusbarHeight+navigationbarHeight+80, screenWidth-80, screenWidth-80)];
//    _timerView.clearsContextBeforeDrawing = YES;
    [self.view addSubview:_timerView];
    [self testShowTimer];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.timer.isValid){
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)timerCountDown{
    if(_workTime-- >= 0){
        [self.timerView drawCircle:((double)_workTime+1)/WORK_TIME andText:[self getTimeStr:_workTime+1]];
    } else {
        if(_restTime-- < 0){
            [_timer invalidate];
        } else {
            [self.timerView drawCircle:((double)_restTime+1)/REST_TIME andText:[self getTimeStr:_restTime+1]];
        }
    }
}

- (NSString *)getTimeStr: (int)time{
    int minutes = time/60;
    int seconds = time-minutes*60;
    return [NSString stringWithFormat:@"%02d:%02d",minutes,seconds];
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
    [_timer fire];
}


@end
