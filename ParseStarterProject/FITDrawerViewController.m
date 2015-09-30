//
//  FITDrawerViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITDrawerViewController.h"
#import "FITLeftMenuViewController.h"
#import "FITRightMenuViewController.h"

@interface FITDrawerViewController ()
@end

@implementation FITDrawerViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.title = NSLocalizedString(@"Fitsei", nil);
    self.view.backgroundColor = [UIColor whiteColor];

    self.rootViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    self.leftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    self.rightViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"RightMenuViewController"];
    
    self.rightViewSwipeGestureEnabled = NO;

    [self setLeftViewEnabledWithWidth:250.f
                    presentationStyle:LGSideMenuPresentationStyleScaleFromBig
                 alwaysVisibleOptions:0];
    
    self.leftViewBackgroundImage = [UIImage imageNamed:@"background_dark"];

    [self setRightViewEnabledWithWidth:100.f
                     presentationStyle:LGSideMenuPresentationStyleScaleFromBig
                  alwaysVisibleOptions:0];
    
    self.rightViewBackgroundImage = [UIImage imageNamed:@"background_dark"];
    
    [self.leftViewController.tableView reloadData];
    [self.leftView addSubview:self.leftViewController.tableView];

    self.rightViewController.tableView.backgroundColor = [UIColor clearColor];
    self.rightViewController.tintColor = [UIColor clearColor];
    [self.rightViewController.tableView reloadData];
    [self.rightView addSubview:self.rightViewController.tableView];
}

- (void)leftViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super leftViewWillLayoutSubviewsWithSize:size];
    
    _leftViewController.tableView.frame = CGRectMake(0.f , 0.f, size.width, size.height);
}

- (void)rightViewWillLayoutSubviewsWithSize:(CGSize)size {
    [super rightViewWillLayoutSubviewsWithSize:size];
    
    _rightViewController.tableView.frame = CGRectMake(0.f , 0.f, size.width, size.height);
}

@end
