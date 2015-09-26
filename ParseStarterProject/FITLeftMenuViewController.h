//
//  FITLeftMenuViewController.h
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftMenuDelegate <NSObject>

- (void)willReplaceViewController;

@end

@interface FITLeftMenuViewController : UITableViewController
@property (strong, nonatomic) UIColor *tintColor;
@property (weak, nonatomic) id<LeftMenuDelegate> delegate;

@end
