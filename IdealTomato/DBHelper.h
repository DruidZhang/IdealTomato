//
//  DBHelper.h
//  IdealTomato
//
//  Created by zb on 2019/1/24.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#ifndef DBHelper_h
#define DBHelper_h
#import "TaskModel.h"

@interface DBHelper : NSObject

+ (BOOL)createTable;

+ (BOOL)insertTask: (TaskModel *)task;

+ (BOOL)deleteTaskById:(int)taskId;

+ (BOOL)updateTask:(TaskModel *)task;

+ (BOOL)updateTaskCompleted: (BOOL)taskCompleted ById: (int)taskId;

+ (BOOL)updateTaskGoodTomato: (BOOL)goodTomato ById: (int)taskId;

+ (BOOL)updateTaskInfoName: (NSString *)taskName Brief:(NSString *)taskBrief Date: (NSDate *)taskDate ById: (int)taskId;

+ (BOOL)incrementTaskBadTomatoCountById: (int)taskId;

+ (TaskModel *)getTaskById: (int)taskId;

+ (int)getBadTomatoCountById: (int)taskId;

//这三个首页列表用到,返回值根据你需要改吧
+ (void)getAllTask;

+ (void)getAllUncompletedTask;

+ (void)getAllCompletedTask;

+ (int)getTaskCount;

+ (int)getUncompletedTaskCount;

+ (int)getCompletedTaskCount;

+ (int)getAllBadTomatoCount;

+ (int)getTodayCompletedTaskCount;

+ (int)getTodayBadTomatoCount;

+ (int)getCompletedTaskCountInDate:(NSDate *)date;

+ (int)getBadTomatoCountInDate:(NSDate *)date;

@end

#endif /* DBHelper_h */
