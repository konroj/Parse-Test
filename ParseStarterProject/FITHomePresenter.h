//
//  FITHomePresenter.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "PFObject.h"

@interface FITHomePresenter : NSObject

- (NSArray *)fetchDiet;
- (FITDayEntity *)fetchTodayDiet;
- (FITDayEntity *)fetchTommorowDiet;

- (void)addRandomObject;

@end
