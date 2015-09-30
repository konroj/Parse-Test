//
//  FITShoppingListPresenter.m
//  Fitsei
//
//  Created by Konrad Roj on 28.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITShoppingListPresenter.h"

typedef void(^completionBlock)(BOOL finished);

@implementation FITShoppingListPresenter

- (M13OrderedDictionary *)fetchShoppingListForThisWeek {
    return [self fetchShoppingListForDates:[self loadDatesForWeek:0]];
}

- (M13OrderedDictionary *)fetchShoppingListForNextWeek {
    return [self fetchShoppingListForDates:[self loadDatesForWeek:1]];
}

- (M13OrderedDictionary *)fetchShoppingListForToday {
    return [self fetchShoppingListForDates:@[[NSDate date]]];
}

- (M13OrderedDictionary *)fetchShoppingListForTommorow {
    NSDateComponents *deltaComps = [NSDateComponents new];
    [deltaComps setDay:1];
    NSDate *tomorrow = [[NSCalendar currentCalendar] dateByAddingComponents:deltaComps toDate:[NSDate date] options:0];
    return [self fetchShoppingListForDates:@[tomorrow]];
}

- (M13OrderedDictionary *)fetchShoppingListForDates:(NSArray *)dates {
    PFQuery *query = [PFQuery queryWithClassName:@"Day"];
    [query fromLocalDatastore];
    
    M13MutableOrderedDictionary *productsDictionary = [M13MutableOrderedDictionary new];
    
    for (NSDate *date in dates) {
        [query whereKey:@"date" equalTo:[self stringFromDate:date]];
        
        FITDayEntity *day = [query findObjects].firstObject;
        
        for (FITDishEntity *dish in [self dishesFromDayEntity:day]) {
            for (FITProductEntity *product in dish.products) {
                [self fetchObject:product];
                NSMutableArray *dataArray = [NSMutableArray arrayWithArray:[productsDictionary objectForKey:product.nameEN]];
                [productsDictionary setObject:[self getProductsFromDishEntity:dataArray product:product] forKey:product.nameEN];
            }
        }

    }
    
    return productsDictionary;
}

- (NSArray *)getProductsFromDishEntity:(NSMutableArray *)dataArray product:(FITProductEntity *)product {
    if (dataArray.count) {
        dataArray[0] = [product localizedName];
        dataArray[1] = [NSNumber numberWithInt:((NSNumber *)dataArray[1]).intValue + product.size.intValue];
        dataArray[2] = [product localizedSuffix];
    } else {
        dataArray[0] = [product localizedName];
        dataArray[1] = product.size;
        dataArray[2] = [product localizedSuffix];
    }
    
    return [NSArray arrayWithArray:dataArray];
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [formatter stringFromDate:date];
}

- (NSArray *)loadDatesForWeek:(NSInteger)week {
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    gregorian.firstWeekday = 2;
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekOfYear fromDate:today];
    NSUInteger weekOfYear = [components weekOfYear];
    weekOfYear+=week;
    
    NSArray *dates = [self datesInWeek:weekOfYear];
    
    return dates;
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

- (void)fetchObject:(PFObject *)object {
    if ([object isDataAvailable]) {
        [object fetchFromLocalDatastoreInBackground];
    } else {
        [object fetchIfNeeded];
        [object pinInBackground];
    }
}

- (NSArray *)dishesFromDayEntity:(FITDayEntity *)dayEntity {
    NSMutableArray *mutableArray = [NSMutableArray new];
    if (dayEntity.breakfast) {
        [self fetchObject:dayEntity.breakfast];
        [mutableArray addObject:dayEntity.breakfast];
    }
    if (dayEntity.secondBreakfast) {
        [self fetchObject:dayEntity.secondBreakfast];
        [mutableArray addObject:dayEntity.secondBreakfast];
    }
    if (dayEntity.dinner) {
        [self fetchObject:dayEntity.dinner];
        [mutableArray addObject:dayEntity.dinner];
    }
    if (dayEntity.snack) {
        [self fetchObject:dayEntity.snack];
        [mutableArray addObject:dayEntity.snack];
    }
    if (dayEntity.lunch) {
        [self fetchObject:dayEntity.lunch];
        [mutableArray addObject:dayEntity.lunch];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

@end
