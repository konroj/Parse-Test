//
//  FITPlanViewController.h
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBaseViewController.h"

@interface FITPlanViewController : FITBaseViewController

@property (strong, nonatomic) NSArray *dates;
@property (strong, nonatomic) NSArray *dayList;

- (void)reloadPlanView;

@end
