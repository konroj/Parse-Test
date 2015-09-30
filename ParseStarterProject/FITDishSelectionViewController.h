//
//  FITDishSelectionViewController.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBaseViewController.h"

@class FITPlanViewController;

@interface FITDishSelectionViewController : FITBaseViewController
@property (weak, nonatomic) FITPlanViewController *planController;
@property (strong, nonatomic) FITDayEntity *dayEntity;
@property (assign, nonatomic) NSInteger index;

@end
