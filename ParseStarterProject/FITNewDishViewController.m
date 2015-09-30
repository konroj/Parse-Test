//
//  FITNewDishViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITNewDishViewController.h"
#import "FITNewDishTableViewCell.h"
#import "FITNavigationViewController.h"

@interface FITNewDishViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation FITNewDishViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Dodaj produkt";
    
    self.tableView.contentInset = UIEdgeInsetsMake(-54, 0, 230, 0);
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor blackColor] duration:0.4f];
}

- (IBAction)addButtonAction:(id)sender {
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11 + 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FITNewDishTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewDishCell" forIndexPath:indexPath];
    
    if (indexPath.row < 11) {
        switch (indexPath.row) {
            case 0: {
                cell.titleLabel.text = @"Typ żywności";
                break;
            }
            case 1: {
                cell.titleLabel.text = @"Typ posiłku";
                break;
            }
            case 2: {
                cell.titleLabel.text = @"Nazwa PL";
                break;
            }
            case 3: {
                cell.titleLabel.text = @"Nazwa EN";
                break;
            }
            case 4: {
                cell.titleLabel.text = @"URL";
                break;
            }
            case 5: {
                cell.titleLabel.text = @"Opis PL";
                break;
            }
            case 6: {
                cell.titleLabel.text = @"Opis EN";
                break;
            }
            case 7: {
                cell.titleLabel.text = @"Białko";
                break;
            }
            case 8: {
                cell.titleLabel.text = @"Węgle";
                break;
            }
            case 9: {
                cell.titleLabel.text = @"Tłuszcz";
                break;
            }
            case 10: {
                cell.titleLabel.text = @"KCAL";
                break;
            }
            default:
                break;
        }
    } else {
        cell.titleLabel.text = [NSString stringWithFormat:@"Produkt %d", indexPath.row - 10];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 10) {
        return 45;
    }
    
    CGFloat size;
    
    switch (indexPath.row) {
        case 5: {
            size = 100;
            break;
        }
        case 6: {
            size = 100;
            break;
        }
        default:
            size = 45;
    }
    
    return size;
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor whiteColor] duration:0.4f];
}

- (void)willReplaceViewController {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor whiteColor] duration:0.4f];
}

@end