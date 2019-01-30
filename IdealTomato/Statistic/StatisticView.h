//
//  StatisticView.h
//  IdealTomato
//
//  Created by zb on 2019/1/30.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#ifndef StatisticView_h
#define StatisticView_h
#import <UIKit/UIKit.h>
#import "StatisticalModel.h"

@interface StatisticView : UIView
- (void)showStatisticViewByTodayModel: (StatisticalModel *)todayModel TotalModel: (StatisticalModel *)totalModel;
@end

#endif /* StatisticView_h */
