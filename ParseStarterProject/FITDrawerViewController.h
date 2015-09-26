//
//  FITDrawerViewController.h
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITLeftMenuViewController;
@class FITRightMenuViewController;

@interface FITDrawerViewController : LGSideMenuController
@property (strong, nonatomic) FITLeftMenuViewController *leftViewController;
@property (strong, nonatomic) FITRightMenuViewController *rightViewController;

@property (assign, nonatomic) NSUInteger leftMenuLastIndex;

@end
