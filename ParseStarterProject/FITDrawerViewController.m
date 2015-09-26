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
    

    [self setLeftViewEnabledWithWidth:250.f
                    presentationStyle:LGSideMenuPresentationStyleScaleFromBig
                 alwaysVisibleOptions:0];
    
    self.leftViewBackgroundImage = [UIImageEffects imageByApplyingTintEffectWithColor:[UIColor colorWithHex:@"#2980b9"] toImage:[UIImage imageNamed:@"background_blue"]];

    [self setRightViewEnabledWithWidth:100.f
                     presentationStyle:LGSideMenuPresentationStyleScaleFromBig
                  alwaysVisibleOptions:0];
    
    self.rightViewBackgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:[UIImage imageNamed:@"left"]];
    
    [_leftViewController.tableView reloadData];
    [self.leftView addSubview:_leftViewController.tableView];

    _rightViewController.tableView.backgroundColor = [UIColor clearColor];
    _rightViewController.tintColor = [UIColor clearColor];
    [_rightViewController.tableView reloadData];
    [self.rightView addSubview:_rightViewController.tableView];
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
