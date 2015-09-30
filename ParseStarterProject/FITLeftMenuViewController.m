//
//  FITLeftMenuViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITLeftMenuViewController.h"
#import "FITRightMenuTableViewCell.h"
#import "FITLeftMenuTableViewCell.h"
#import "FITLogoTableViewCell.h"
#import "FITPlanViewController.h"

@interface FITLeftMenuViewController ()
@property (strong, nonatomic) NSArray *titlesArray;
@property (strong, nonatomic) NSMutableArray *cellArray;
@property (assign, nonatomic) NSUInteger lastIndex;
@end

@implementation FITLeftMenuViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titlesArray = @[
                         NSLocalizedString(@"Today", nil),
                         NSLocalizedString(@"Diet plan", nil),
                         NSLocalizedString(@"Shopping list", nil),
                         @"",
                         NSLocalizedString(@"Settings", nil)];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.contentInset = UIEdgeInsetsMake(67.0f, 0.f, 67.0f, 0.f);
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark -

- (void)openLeftView {
    [FITMainViewController showLeftViewAnimated:YES completionHandler:nil];
}

- (void)openRightView {
    [FITMainViewController showRightViewAnimated:YES completionHandler:nil];
}

#pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titlesArray.count + 1;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FITLogoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LogoCell" forIndexPath:indexPath];
        
        return cell;
    }
    
    FITLeftMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftMenuCell"];
    
    cell.label.text = self.titlesArray[indexPath.row - 1];
    
    switch (indexPath.row) {
        case 1: {
            [cell leftImage:@"day"];
            break;
        }
        case 2: {
            [cell leftImage:@"calendar"];
            break;
        }
        case 3: {
            [cell leftImage:@"shop"];
            break;
        }
        case 5: {
            [cell leftImage:@"setting"];
            break;
        }
            
        default:
            break;
    }
    
    if (indexPath.row == 4) {
        cell.userInteractionEnabled = NO;
        cell.leftImage.hidden = YES;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 145.0f;
    }
    return ((self.view.frame.size.height - 134.0f - 145.0f) / 5);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        return;
    }
    
    if ([self.delegate respondsToSelector:@selector(willReplaceViewController)]) {
        [self.delegate willReplaceViewController];
    }
    
    UIViewController *viewController;
    if (indexPath.row == 1) {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    } else if (indexPath.row == 2) {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PlanViewController"];
        viewController.title = self.titlesArray[indexPath.row - 1];
    } else if (indexPath.row == 3) {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ShoppingViewController"];
        viewController.title = self.titlesArray[indexPath.row - 1];
    } else if (indexPath.row == 5) {
        viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingsViewController"];
        viewController.title = self.titlesArray[indexPath.row - 1];
    }
  
    if (viewController == nil || [viewController isKindOfClass:[((UINavigationController *)FITNavigationController).viewControllers.lastObject class]]) {
        [FITMainViewController hideLeftViewAnimated:YES completionHandler:nil];
        return;
    }
    
    for (UIViewController *vc in ((UINavigationController *)FITNavigationController).viewControllers) {
        if ([vc isKindOfClass:[viewController class]]) {
            [FITNavigationController popToViewController:vc animated:YES];
            [FITMainViewController hideLeftViewAnimated:YES completionHandler:nil];
            return;
        }
    }
    
    [FITNavigationController pushViewController:viewController animated:YES];
    [FITMainViewController hideLeftViewAnimated:YES completionHandler:nil];
}

@end
