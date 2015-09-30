//
//  FITBaseViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBaseViewController.h"

@interface FITBaseViewController ()

@end

@implementation FITBaseViewController

- (void)openLeftView {
    [FITMainViewController showLeftViewAnimated:YES completionHandler:nil];
}

- (void)openRightView {
    [FITMainViewController showRightViewAnimated:YES completionHandler:nil];
}

- (void)pushViewControllerAction {
    UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    viewController.title = @"Test";
    [FITNavigationController pushViewController:viewController animated:YES];
}

- (void)addNavigationBarLeft {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Left" style:UIBarButtonItemStylePlain target:self action:@selector(openRightView)];
}

- (void)addNavigationBarRight {
    UIImage *image = [[UIImage imageNamed:@"hamburger"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(openLeftView)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
}

- (void)addTwoBarRight {
    UIImage *hamburger = [[UIImage imageNamed:@"hamburger"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIImage *calendar = [[UIImage imageNamed:@"calendar"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithImage:calendar style:UIBarButtonItemStylePlain target:self action:@selector(openRightView)];
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:hamburger style:UIBarButtonItemStylePlain target:self action:@selector(openLeftView)];
    
    [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:left, right, nil]];
}

@end
