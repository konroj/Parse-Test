//
//  FITRightMenuViewController.h
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol RightMenuDelegate <NSObject>

- (void)didSelectRightMenuIndex:(NSInteger)index;

@end

@interface FITRightMenuViewController : UITableViewController
@property (strong, nonatomic) UIColor *tintColor;
@property (weak, nonatomic) id<RightMenuDelegate> delegate;

@end
