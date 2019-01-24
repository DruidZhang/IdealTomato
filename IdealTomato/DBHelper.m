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

@implementation DBHelper

+ (FMDatabase *)openDB{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:@"IdealTomato.db"];
    FMDatabase *db = [FMDatabase databaseWithPath:filePath];
    if(![db open]){
        NSLog(@"error:faile to op db");
        return nil;
    }
    return db;
}

+ (void)createTable{
    NSUserDefaults *dbDefaults = [NSUserDefaults standardUserDefaults];
    if(![dbDefaults boolForKey:@"CREATED"]){
        FMDatabase *db = [self openDB];
        if(db == nil) return;
        NSString *sql = @"create table if not exists task(taskId integer primary key autoincrement,\
                                                        taskName varchar(50),\
                                                        taskBrief varchar(100),\
                                                        taskDate datetime,\
                                                        taskCompleted bool,\
                                                        goodTomato bool,\
                                                        badTomatoCount integer)";
        if([db executeUpdate:sql]){
            NSLog(@"create table task");
            [dbDefaults setBool:YES forKey:@"CREATED"];
        }
    }
}

+ (void)insertTask:(TaskModel *)task{
    FMDatabase *db = [self openDB];
    if(db==nil) return;
    NSString *sql = @"insert into task values(?,?,?,?,?,?)";
    BOOL result = [db executeUpdate:sql,task.taskName,task.taskBrief,task.taskDate,@(task.taskCompleted),@(task.goodTomato),@(task.badTomatoCount)];
    if(!result){
        NSLog(@"error:faile to insert into task");
    }
}


@end
