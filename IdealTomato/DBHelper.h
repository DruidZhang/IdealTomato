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

+ (void)createTable;

+ (void)insertTask: (TaskModel *)task;

+ (void)deleteTaskById:(int)taskId;

+ (void)updateTask:(TaskModel *)task;

+ (void)updateTaskCompleted: (BOOL)taskCompleted ById: (int)taskId;

+ (void)updateTaskGoodTomato: (BOOL)goodTomato ById: (int)taskId;

+ (void)updateTaskInfoName: (NSString *)taskName Brief:(NSString *)taskBrief Date: (NSDate *)taskDate ById: (int)taskId;

+ (void)incrementTaskBadTomatoCountById: (int)taskId;

+ (TaskModel *)getTaskById: (int)taskId;

//这三个首页列表用到,返回值根据你需要改吧
+ (void)getAllTask;

+ (void)getAllUncompletedTask;

+ (void)getAllCompletedTask;

+ (int)getTaskCount;

+ (int)getUncompletedTaskCount;

+ (int)getCompletedTaskCount;

@end

#endif /* DBHelper_h */
