//
//  Tomato.h
//  IdealTomato
//
//  Created by zb on 2019/1/17.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#ifndef Tomato_h
#define Tomato_h


@interface  Tomato : NSObject

@property int tomatoId;
@property NSString *taskName;
@property NSString *taskBrief;
@property NSDate *taskDate;
@property BOOL taskCompleted;

@end


#endif /* Tomato_h */
