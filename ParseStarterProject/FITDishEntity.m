//
//  FITDishEntity.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITDishEntity.h"

@implementation FITDishEntity

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Dish";
}

- (NSString *)localizedName {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"pl-PL"]) {
        return self.namePL;
    } else {
        return self.nameEN;
    }
}

- (NSString *)localizedDescription {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"pl-PL"]) {
        return self.descriptionPL;
    } else {
        return self.descriptionEN;
    }
}

@end
