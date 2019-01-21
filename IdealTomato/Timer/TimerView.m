//
//  TimerView.m
//  IdealTomato
//
//  Created by zb on 2019/1/15.
//  Copyright © 2019 IdealCountry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimerView.h"

@interface TimerView()
@property double angle;
@property NSString *timeStr;
@property UILabel *label;
@end

@implementation TimerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat viewX = CGRectGetMinX(self.bounds);
        CGFloat viewY = CGRectGetMinY(self.bounds);
        CGFloat viewWidth = CGRectGetWidth(self.bounds);
        CGFloat viewHeight = CGRectGetHeight(self.bounds);
        CGFloat dx = 40;
        CGFloat dy = 100;
        _label = [[UILabel alloc]initWithFrame:CGRectMake(viewX+dx, viewY+dy, viewWidth-2*dx, viewHeight-2*dy)];
        //    label.backgroundColor = [UIColor whiteColor];
        _label.textColor = [UIColor blackColor];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont boldSystemFontOfSize:60.0f];
        [self addSubview:_label];
    }
    return self;
}

- (void)drawCircle: (double)angle andText: (NSString *)timeStr{
    self.angle = angle;
    self.timeStr = timeStr;
    [_label setText:timeStr];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect{
    [[UIColor whiteColor]set];
//    CGContextClearRect(UIGraphicsGetCurrentContext(), rect);
    //减6为了圆圈不被遮挡
    CGFloat radius = CGRectGetWidth(rect)/2-6;
    CGFloat Ox = CGRectGetMidX(rect);
    CGFloat Oy = CGRectGetMidY(rect);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextFillRect(context, rect);
    CGContextSetLineWidth(context, 12);
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    CGContextAddArc(context, Ox, Oy, radius, 3*M_PI/2, -2*M_PI*_angle+3*M_PI/2, 1);
//    CGContextAddArc(context, Ox, Oy, radius, 0, 2*M_PI, 1);
    CGContextDrawPath(context, kCGPathStroke);
}

@end
