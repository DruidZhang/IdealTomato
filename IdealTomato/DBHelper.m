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

+ (void)createTable{
    NSUserDefaults *dbDefaults = [NSUserDefaults standardUserDefaults];
    if(![dbDefaults boolForKey:@"CREATED"]){
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *filePath = [path stringByAppendingPathComponent:@"IdealTomato.db"];
        FMDatabase *db = [FMDatabase databaseWithPath:filePath];
        if(![db open]){
            NSLog(@"db open fail");
            return;
        }
        NSString *sql = @"create table if not exists task(taskId integer primary key,\
                                                        taskName varchar(50),\
                                                        taskBrief varchar(100),\
                                                        taskDate datetime,\
                                                        taskCompleted bool,\
                                                        goodTomato bool,\
                                                        badTomatoCount int)";
        if([db executeUpdate:sql]){
            NSLog(@"create table task");
            [dbDefaults setBool:YES forKey:@"CREATED"];
        }
    }
}

@end
