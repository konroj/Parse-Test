//
//  FITRightMenuViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITRightMenuViewController.h"
#import "FITRightMenuTableViewCell.h"

@interface FITRightMenuViewController ()
@property (strong, nonatomic) NSArray *titlesArray;
@end

@implementation FITRightMenuViewController

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.titlesArray = @[@"Set VC",
                     @"Open Left View",
                     @"",
                     @"1",
                     @"2",
                     @"3",
                     @"4",
                     @"5",
                     @"6",
                     @"7",
                     @"8",
                     @"9",
                     @"10"];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor clearColor];
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
    return self.titlesArray.count;
}

#pragma mark - UITableView Delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FITRightMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = _titlesArray[indexPath.row];
    if (indexPath.row < 3) {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:15.f];
    } else {
        cell.textLabel.font = [UIFont boldSystemFontOfSize:30.f];
    }
    //cell.separatorView.hidden = !(indexPath.row != _titlesArray.count-1 && indexPath.row != 1 && indexPath.row != 2);
    cell.userInteractionEnabled = (indexPath.row != 2);
    
    cell.tintColor = _tintColor;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2) return 50.f;
    else return 100.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        FITHomeViewController *viewController = [FITNavigationController viewControllers].firstObject;
        
        UIViewController *viewController2 = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        viewController2.title = @"Test";
        
        [FITNavigationController setViewControllers:@[viewController, viewController2]];
        
        [FITMainViewController hideRightViewAnimated:YES completionHandler:nil];
    } else if (indexPath.row == 1) {
        if (![FITMainViewController isRightViewAlwaysVisible]) {
            [FITMainViewController hideRightViewAnimated:YES completionHandler:^(void) {
                 [FITMainViewController showLeftViewAnimated:YES completionHandler:nil];
            }];
        }
        else [FITMainViewController showLeftViewAnimated:YES completionHandler:nil];
    } else {
        UIViewController *viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        viewController.title = [NSString stringWithFormat:@"Test %@", _titlesArray[indexPath.row]];
        [FITNavigationController pushViewController:viewController animated:YES];
        
        [FITMainViewController hideRightViewAnimated:YES completionHandler:nil];
    }
}

@end
