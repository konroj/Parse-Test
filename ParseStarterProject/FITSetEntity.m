//
//  FITSetEntity.m
//  Fitsei
//
//  Created by Konrad Roj on 02.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSetEntity.h"

@implementation FITSetEntity

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Set";
}

@end
