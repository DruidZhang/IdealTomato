//
//  TimerView.h
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#ifndef TimerView_h
#define TimerView_h

#import <UIKit/UIKit.h>

@interface TimerView : UIView

- (void)drawCircle: (double)angle andText: (NSString *)timeStr;

@end

#endif /* TimerView_h */
