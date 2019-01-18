//
//  TimerViewController.h
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#ifndef TimerViewController_h
#define TimerViewController_h

#import <UIKit/UIKit.h>
#import "../TaskModel.h"

@interface TimerViewController : UIViewController

- (void)showTimerWith: (TaskModel *)task andDo: (void (^)(void))tomatoDone;

@end

#endif /* TimerViewController_h */
