//
//  StatisticView.m
//  IdealTomato
//
//  Created by zb on 2019/1/30.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StatisticView.h"

@interface StatisticView()

@property UILabel* label_todayCompletedTask;
@property UILabel* label_todayGoodTomato;
@property UILabel* label_todayBadTomato;

@property UILabel* label_totalCompletedTask;
@property UILabel* label_totalGoodTomato;
@property UILabel* label_totalBadTomato;

@end

@implementation StatisticView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //今日收成view
        //dividerView
        //历史收成view
    }
    return self;
}

- (void)showStatisticViewByTodayModel:(StatisticalModel *)todayModel TotalModel:(StatisticalModel *)totalModel {
    
}


@end
