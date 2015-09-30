//
//  FITDietPlanPresenter.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITDietPlanPresenter.h"

@implementation FITDietPlanPresenter

- (NSArray *)fetchDietPlanForDates:(NSArray *)dates {
    PFQuery *query = [PFQuery queryWithClassName:@"Day"];
    [query fromLocalDatastore];
    
    NSMutableArray *dayList = [NSMutableArray new];
    
    for (NSDate *date in dates) {
        [query whereKey:@"date" equalTo:[self stringFromDate:date]];
        
        FITDayEntity *day = [query findObjects].firstObject;
        
        if (!day) {
            day = [FITDayEntity new];
        }
        
        day.date = [self stringFromDate:date];
        
        [dayList addObject:day];
    }
    
    [PFObject pinAllInBackground:dayList];
    
    return [NSArray arrayWithArray:dayList];
}

- (NSArray *)datesInWeek:(NSInteger)weekNumber {
    NSCalendar *greg = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    greg.firstWeekday = 2;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.day = 1;
    NSDate *today = [NSDate date];
    NSDate *tomorrow = [greg dateByAddingComponents:comps toDate:today options:nil];
    const NSTimeInterval kDay = [tomorrow timeIntervalSinceDate:today];
    comps = [greg components:NSCalendarUnitYear fromDate:[NSDate date]];
    comps.day = 1;
    comps.month = 1;
    comps.hour = 12;
    NSDate *start = [greg dateFromComponents:comps];
    comps = [greg components:NSCalendarUnitWeekday fromDate:start];
    if (weekNumber==1) {
        start = [start dateByAddingTimeInterval:-kDay*(comps.weekday-1)];
    } else {
        start = [start dateByAddingTimeInterval:
                 kDay*(8-comps.weekday+7*(weekNumber-2))];
    }
    NSMutableArray *result = [NSMutableArray array];
    for (int i = 1; i<8; i++) {
        [result addObject:[start dateByAddingTimeInterval:kDay*i]];
    }
    return [NSArray arrayWithArray:result];
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [formatter stringFromDate:date];
}

@end
