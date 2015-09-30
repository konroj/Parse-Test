//
//  FITDayEntity.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "PFObject.h"

@class FITDishEntity;

@interface FITDayEntity : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) FITDishEntity *breakfast;
@property (strong, nonatomic) FITDishEntity *secondBreakfast;
@property (strong, nonatomic) FITDishEntity *lunch;
@property (strong, nonatomic) FITDishEntity *snack;
@property (strong, nonatomic) FITDishEntity *dinner;

@end