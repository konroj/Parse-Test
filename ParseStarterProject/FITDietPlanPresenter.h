//
//  FITDietPlanPresenter.h
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITDietPlanPresenter : NSObject

- (NSArray *)datesInWeek:(NSInteger)weekNumber;
- (NSString *)stringFromDate:(NSDate *)date;
- (NSArray *)fetchDietPlanForDates:(NSArray *)dates;

@end
