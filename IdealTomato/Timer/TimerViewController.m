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
#import "../DBHelper.h"


@interface TimerViewController()

@property const int a;

@property TimerView *timerView;
@property TaskModel *task;
@property NSTimer *timer;
@property UILabel *label_taskName;
@property int workTime;
@property int restTime;
@property BOOL timerRunning;
@property(nonatomic, copy) void (^tomatoDone)(void);

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
        _timerRunning = NO;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColor.whiteColor;
    self.tabBarController.tabBar.hidden = YES;
#pragma mark - 创建TimerView
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
    _timerView.userInteractionEnabled = YES;
    //timerView添加点击手势
    UITapGestureRecognizer *clickGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(timerViewClick)];
    //单指
    clickGesture.numberOfTouchesRequired = 1;
    //单击
    clickGesture.numberOfTapsRequired = 1;
    [_timerView addGestureRecognizer:clickGesture];
    [self.view addSubview:_timerView];
#pragma mark - 创建taskName的label
    _label_taskName = [[UILabel alloc] init];
    _label_taskName.frame = CGRectMake(40, statusbarHeight+navigationbarHeight+screenWidth+80, screenWidth-80, 40);
    _label_taskName.textColor = [UIColor blackColor];
    _label_taskName.textAlignment = NSTextAlignmentCenter;
    _label_taskName.font = [UIFont systemFontOfSize:20.0f];
    _label_taskName.backgroundColor = [UIColor redColor];
    [self.view addSubview:_label_taskName];
    
    [self testShowTimer];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(self.timer.isValid){
        [self.timer invalidate];
        self.timer = nil;
    }
    //对比self和db的task,不同则用self的刷新 ?
    if(self.tomatoDone != nil){
        self.tomatoDone();
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

- (void)timerViewClick{
    __weak __typeof(self)weakSelf = self;
    if(_timerRunning){
        //暂停
        NSDate *future = [NSDate distantFuture];
        [_timer setFireDate:future];
#pragma mark - work time的点击dialog
        //上拉菜单的style为UIAlertControllerStyleActionSheet,注意style为UIAlertActionStyleCancel的action默认在最下
        UIAlertController *workAC = [UIAlertController alertControllerWithTitle:@"确定要放弃?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
             [weakSelf.timer setFireDate:[NSDate date]];
        }];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"放弃" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
//            [DBHelper incrementTaskBadTomatoCountById:weakSelf.task.taskId];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        UIAlertAction *doneAction = [UIAlertAction actionWithTitle:@"已完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [DBHelper updateTaskCompleted:YES ById:weakSelf.task.taskId];
//            [DBHelper updateTaskGoodTomato:YES ById:weakSelf.task.taskId];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        //style为UIAlertActionStyleDestructive的action显示是红色的
//        UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:nil];
        [workAC addAction:cancelAction];
        [workAC addAction:okAction];
        [workAC addAction:doneAction];
        
#pragma mark - rest time的点击dialog
        UIAlertController *restAC = [UIAlertController alertControllerWithTitle:@"确认跳过休息?" message:nil preferredStyle:UIAlertControllerStyleAlert];
        //直接复用work的action会出现不响应的问题
        UIAlertAction *restCancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action){
            [weakSelf.timer setFireDate:[NSDate date]];
        }];
        UIAlertAction *restOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//            [DBHelper updateTaskCompleted:YES ById:weakSelf.task.taskId];
//            [DBHelper updateTaskGoodTomato:YES ById:weakSelf.task.taskId];
            [self.navigationController popViewControllerAnimated:YES];
        }];
        [restAC addAction:restCancelAction];
        [restAC addAction:restOK];
        
        if(_workTime >=0){
            //work time
            [self presentViewController:workAC animated:YES completion:nil];
        } else if(_restTime >=0){
            [self presentViewController:restAC animated:YES completion:nil];
        }
        //关闭dialog
//        [alertController dismissViewControllerAnimated:YES completion:nil];
    } else {
        //开始
        //这里用[timer fire]就出现只运行1s的问题
        [_timer setFireDate:[NSDate date]];
        _timerRunning = !_timerRunning;
    }
}

- (void)testShowTimer {
    _task = [[TaskModel alloc]init];
    _task.taskName = @"测试任务";
    _label_taskName.text = _task.taskName;

    //加入循环池
    [[NSRunLoop mainRunLoop]addTimer:_timer forMode:NSDefaultRunLoopMode];
    //开始循环
    _timerRunning = YES;
    [_timer fire];
}

- (void)showTimerWith:(TaskModel *)task andDo:(void (^)(void))tomatoDone{
    self.task = task;
    _label_taskName.text = _task.taskName;
    self.tomatoDone = tomatoDone;
    //加入循环池
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
    //开始循环
    _timerRunning = YES;
    [_timer fire];
}


@end
