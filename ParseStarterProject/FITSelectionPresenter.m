//
//  FITSelectionPresenter.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSelectionPresenter.h"

@implementation FITSelectionPresenter

- (NSDictionary *)fetchDishesWithIndex:(NSUInteger)index {
    PFQuery *query = [PFQuery queryWithClassName:@"Dish"];
    [query fromLocalDatastore];
    
    NSArray *dishes = [query findObjects];
    
    NSString *textIndex = [self textForIndex:index];
    
    NSMutableArray *meat = [NSMutableArray new];
    NSMutableArray *fish = [NSMutableArray new];
    NSMutableArray *vege = [NSMutableArray new];
    
    NSMutableDictionary *dict = [NSMutableDictionary new];
    
    for (FITDishEntity *dish in dishes) {
        if ([dish.dishType isEqualToString:textIndex]) {
            if ([dish.foodType isEqualToString:@"Meat"]) {
                [meat addObject:dish];
            } else if ([dish.foodType isEqualToString:@"Fish"]) {
                [fish addObject:dish];
            } else if ([dish.foodType isEqualToString:@"Vege"]) {
                [vege addObject:dish];
            }
        }
    }
    
    if (meat.count) {
        [dict setObject:meat forKey:@"Meat"];
    }
    if (fish.count) {
        [dict setObject:fish forKey:@"Fish"];
    }
    if (vege.count) {
        [dict setObject:vege forKey:@"Vege"];
    }
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

- (NSString *)textForIndex:(NSUInteger)index {
    NSString *text;
    
    switch (index) {
        case 0: {
            text = @"Breakfast";
            break;
        }
        case 1: {
            text = @"Second breakfast";
            break;
        }
        case 2: {
            text = @"Lunch";
            break;
        }
        case 3: {
            text = @"Snack";
            break;
        }
        case 4: {
            text = @"Dinner";
            break;
        }
        default:
            break;
    }
    
    return text;
}

@end
