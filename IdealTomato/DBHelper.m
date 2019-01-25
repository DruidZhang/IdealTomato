//
//  DBHelper.m
//  IdealTomato
//
//  Created by zb on 2019/1/24.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DBHelper.h"
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@implementation DBHelper

+ (FMDatabase *)openDB{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"IdealTomato.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:filePath];
    if(![db open]){
        NSLog(@"error:fail to op db");
        return nil;
    }
    return db;
}

+ (BOOL)dbExecuteUpdate: (NSString *)sql,... {
    FMDatabase *db = [self openDB];
    if(db == nil) return NO;
    va_list args;
    va_start(args, sql);
    BOOL result = [db executeUpdate:sql withVAList:args];
    va_end(args);
    [db close];
    return result;
}

+ (int)dbIntForQuery: (NSString *)sql,... {
    FMDatabase *db = [self openDB];
    if(db == nil) return -1;
    va_list args;
    va_start(args, sql);
    int result = [db intForQuery:sql,args];
    va_end(args);
    [db close];
    return result;
}

+ (BOOL)createTable{
    NSUserDefaults *dbDefaults = [NSUserDefaults standardUserDefaults];
    if(![dbDefaults boolForKey:@"CREATED"]){
        FMDatabase *db = [self openDB];
        if(db == nil) return NO;
        NSString *sql = @"create table if not exists task(taskId integer primary key autoincrement,\
                                                        taskName varchar(50),\
                                                        taskBrief varchar(100),\
                                                        taskDate datetime,\
                                                        taskCompleted bool,\
                                                        goodTomato bool,\
                                                        badTomatoCount integer)";
        if(![db executeUpdate:sql]){
            [db close];
            return NO;
        }
        NSLog(@"create table task");
        [dbDefaults setBool:YES forKey:@"CREATED"];
    }
    return YES;
}

+ (BOOL)insertTask:(TaskModel *)task{
    BOOL result = [self dbExecuteUpdate: @"insert into task values(?,?,?,?,?,?)",task.taskName,
                   task.taskBrief,task.taskDate,@(task.taskCompleted),@(task.goodTomato),@(task.badTomatoCount)];
    if(!result){
        NSLog(@"error:fail to insert into task where taskName = %@",task.taskName);
    }
    return result;
}

+ (BOOL)deleteTaskById:(int)taskId{
    BOOL result = [self dbExecuteUpdate: @"delete from task where taskId = ?",taskId];
    if(!result){
        NSLog(@"error:fail to delete from task where taskId = %d",taskId);
    }
    return result;
}

+ (BOOL)updateTask:(TaskModel *)task{
    BOOL result = [self dbExecuteUpdate: @"update task set taskName = ?, taskBrief = ?, taskDate = ?, taskCompleted = ?, goodTomato = ?, badTomatoCount = ?\
                   where taskId = ?",task.taskName,task.taskBrief,task.taskDate,@(task.taskCompleted),@(task.goodTomato),@(task.badTomatoCount),@(task.taskId)];
    if(!result){
        NSLog(@"error:fail to update task where taskName = %@",task.taskName);
    }
    return result;
}

+ (BOOL)updateTaskCompleted:(BOOL)taskCompleted ById:(int)taskId{
    BOOL result = [self dbExecuteUpdate: @"update task set taskCompleted = ? where taskId = ?",@(taskCompleted),@(taskId)];
    if(!result){
        NSLog(@"error:fail to update taskCompleted where taskId = %d",taskId);
    }
    return result;
}

+ (BOOL)updateTaskGoodTomato:(BOOL)goodTomato ById:(int)taskId{
    BOOL result = [self dbExecuteUpdate: @"update task set goodTomato = ? where taskId = ?",@(goodTomato),@(taskId)];
    if(!result){
        NSLog(@"error:fail to update taskCompleted where taskId = %d",taskId);
    }
    return result;
}

+ (BOOL)updateTaskInfoName:(NSString *)taskName Brief:(NSString *)taskBrief Date:(NSDate *)taskDate ById:(int)taskId{
    BOOL result = [self dbExecuteUpdate: @"update task set taskName = ?, taskBrief = ?, taskDate = ? where taskId = ?",taskName,taskBrief,taskDate,@(taskId)];
    if(!result){
        NSLog(@"error:fail to update taskCompleted where taskName = %@",taskName);
    }
    return result;
}

+ (BOOL)incrementTaskBadTomatoCountById:(int)taskId{
    int count = [self getBadTomatoCountById:taskId]+1;
    BOOL result = [self dbExecuteUpdate: @"update task set badTomatoCount = ? where taskId = ?",@(count),@(taskId)];
    if(!result){
        NSLog(@"error:fail to update taskCompleted where taskId = %d",taskId);
    }
    return result;
}

+ (TaskModel *)getTaskById:(int)taskId{
    FMDatabase *db = [self openDB];
    if(db == nil) return nil;
    TaskModel *task = [[TaskModel alloc]init];
    FMResultSet * resultSet = [db executeQueryWithFormat:@"select * from task where taskId = %d",taskId];
    if(resultSet.next){
        task.taskName = [resultSet stringForColumn:@"taskName"];
        task.taskBrief = [resultSet stringForColumn:@"taskBrief"];
        task.taskDate = [resultSet dateForColumn:@"taskDate"];
        task.taskCompleted = [resultSet boolForColumn:@"taskCompleted"];
        task.goodTomato = [resultSet boolForColumn:@"goodTomato"];
        task.badTomatoCount = [resultSet intForColumn:@"badTomatoCount"];
    }
    [db close];
    return task;
}

+ (int)getBadTomatoCountById:(int)taskId{
    return [self dbIntForQuery:@"select badTomatoCount from task where taskId = ?",@(taskId)];
}

+ (int)getTaskCount{
    return [self dbIntForQuery:@"select count(*) from task"];
}

+ (int)getUncompletedTaskCount{
    return [self dbIntForQuery:@"select count(*) from task where taskCompleted = false"];
}

+ (int)getCompletedTaskCount{
    return [self dbIntForQuery:@"select count(*) from task where taskCompleted = true"];
}

+ (int)getAllBadTomatoCount{
    return [self dbIntForQuery:@"select sum(badTomatoCount) from task"];
}

@end
