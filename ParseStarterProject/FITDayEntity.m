//
//  FITDayEntity.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITDayEntity.h"

@implementation FITDayEntity

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Day";
}

@end
