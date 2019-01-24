//
//  TaskModel.h
//  IdealTomato
//
//  Created by zb on 2019/1/18.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#ifndef TaskModel_h
#define TaskModel_h

@interface TaskModel : NSObject

@property int taskId;
@property NSString *taskName;
@property NSString *taskBrief;
@property NSDate *taskDate;
@property BOOL taskCompleted;
@property BOOL goodTomato;
@property int badTomatoCount;

@end

#endif /* TaskModel_h */
