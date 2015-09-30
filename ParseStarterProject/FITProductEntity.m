//
//  FITProductEntity.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITProductEntity.h"

@implementation FITProductEntity

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Product";
}

- (NSString *)localizedName {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"pl-PL"]) {
        return self.namePL;
    } else {
        return self.nameEN;
    }
}

- (NSString *)localizedSuffix {
    NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
    if ([language isEqualToString:@"pl-PL"]) {
        return self.suffixPL;
    } else {
        return self.suffixEN;
    }
}

@end
