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
    
    self.titlesArray = @[NSLocalizedString(@"This week", nil), NSLocalizedString(@"Next week", nil)];
    
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    self.tableView.contentInset = UIEdgeInsetsMake(67.0f, 0.f, 67.0f, 0.f);
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FITRightMenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.textLabel.text = self.titlesArray[indexPath.row];
    cell.textLabel.numberOfLines = 2;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f weight:UIFontWeightThin];
    cell.textLabel.textColor = [UIColor whiteColor];

    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if ([self.delegate respondsToSelector:@selector(didSelectRightMenuIndex:)]) {
        [self.delegate didSelectRightMenuIndex:indexPath.row];
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        [FITMainViewController hideRightViewAnimated:YES completionHandler:nil];
    });
}

@end
