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
#import "FITNewProductTableViewCell.h"

@interface FITNewDishViewController () <UITableViewDataSource, UITableViewDelegate, NewProductDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *products;
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
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 11 + self.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    
    if (indexPath.row < 11) {
        FITNewDishTableViewCell *dishCell = [tableView dequeueReusableCellWithIdentifier:@"NewDishCell" forIndexPath:indexPath];
        
        switch (indexPath.row) {
            case 0: {
                dishCell.titleLabel.text = @"Typ żywności";
                break;
            }
            case 1: {
                dishCell.titleLabel.text = @"Typ posiłku";
                break;
            }
            case 2: {
                dishCell.titleLabel.text = @"Nazwa PL";
                break;
            }
            case 3: {
                dishCell.titleLabel.text = @"Nazwa EN";
                break;
            }
            case 4: {
                dishCell.titleLabel.text = @"URL";
                break;
            }
            case 5: {
                dishCell.titleLabel.text = @"Opis PL";
                break;
            }
            case 6: {
                dishCell.titleLabel.text = @"Opis EN";
                break;
            }
            case 7: {
                dishCell.titleLabel.text = @"Białko";
                break;
            }
            case 8: {
                dishCell.titleLabel.text = @"Węgle";
                break;
            }
            case 9: {
                dishCell.titleLabel.text = @"Tłuszcz";
                break;
            }
            case 10: {
                dishCell.titleLabel.text = @"KCAL";
                break;
            }
            default:
                break;
        }
        
        cell = dishCell;
    } else {
        FITNewProductTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"NewProductCell" forIndexPath:indexPath];
        productCell.titleLabel.text = [NSString stringWithFormat:@"Produkt %ld", indexPath.row - 10];
        
        cell = productCell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row > 10) {
        return 65;
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

- (void)addNewProductCell:(id)sender {
    [self.products addObject:[FITProductEntity new]];
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