//
//  FITSetSelectionViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 01.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSetSelectionViewController.h"
#import "FITSetTableViewCell.h"

@interface FITSetSelectionViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FITSetSelectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Standard diets", nil);
    
    [self addNavigationBarRight];
    self.tableView.backgroundColor = [UIColor clearColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FITSetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SetCell" forIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [FITSetTableViewCell cellHeight];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

@end
