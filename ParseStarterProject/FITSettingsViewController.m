//
//  FITSettingsViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSettingsViewController.h"
#import "FITSettingsTableViewCell.h"

@interface FITSettingsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FITSettingsViewController

- (void)awakeFromNib {
    [self addNavigationBarRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(25.0f + 64.0f, 0, 25.0f, 0);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FITSettingsTableViewCell *settingsCell = [tableView dequeueReusableCellWithIdentifier:@"SettingsCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            settingsCell.leftImageView.image = [UIImage imageNamed:@"notifications"];
            settingsCell.label.text = NSLocalizedString(@"Notifications", nil);
            [settingsCell controlWithTitles:NSLocalizedString(@"ON", nil) second:NSLocalizedString(@"OFF", nil)];
            settingsCell.control.selectedSegmentIndex = 1;
            break;
        }
        case 1: {
            settingsCell.leftImageView.image = [UIImage imageNamed:@"shopNotif"];
            settingsCell.label.text = NSLocalizedString(@"Shopping list", nil);
            [settingsCell controlWithTitles:NSLocalizedString(@"DAY", nil) second:NSLocalizedString(@"WEEK", nil)];
            settingsCell.control.selectedSegmentIndex = 0;
            
            break;
        }
        default:
            break;
    }
    
    return settingsCell;
}

@end
