//
//  FITNavigationViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITNavigationViewController.h"

@interface FITNavigationViewController ()
@property (strong, nonatomic) UIView *statusBarView;
@end

@implementation FITNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 600, 22)];
    self.statusBarView.backgroundColor  =  [UIColor clearColor];
    [self.view addSubview:self.statusBarView];

    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.shadowImage = [UIImage new];
    self.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor clearColor];
    self.navigationBar.backgroundColor = [UIColor clearColor];
    self.navigationBar.tintColor = [UIColor whiteColor];

    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setValue:[UIFont systemFontOfSize:17.0f weight:UIFontWeightUltraLight] forKey:NSFontAttributeName];
    [[UIBarButtonItem appearance] setTitleTextAttributes:attributes forState:UIControlStateNormal];
}

- (void)animateNavigationBarFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor duration:(NSTimeInterval)duration {
    
    if ([toColor isEqual:[UIColor clearColor]]) {
        [UIView animateWithDuration:duration animations:^{
            self.statusBarView.backgroundColor = [UIColor clearColor];
            self.view.backgroundColor = [UIColor clearColor];
            self.navigationBar.backgroundColor = [UIColor clearColor];
        }];
    } else {
        [UIView animateWithDuration:duration animations:^{
            self.statusBarView.backgroundColor = toColor;
            self.view.backgroundColor = toColor;
            self.navigationBar.backgroundColor = toColor;
        }];
    }
}

@end
