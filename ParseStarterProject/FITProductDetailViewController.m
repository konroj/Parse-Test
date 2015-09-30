//
//  FITProductDetailViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITProductDetailViewController.h"
#import "FITProductImageTableViewCell.h"
#import "FITProductDetailTableViewCell.h"
#import "FITNavigationViewController.h"
#import "FITLeftMenuViewController.h"
#import "FITProductInfoTableViewCell.h"
#import "FITProductTitleTableViewCell.h"
#import "FITProductLongTextTableViewCell.h"

@interface FITProductDetailViewController () <UITableViewDataSource, UITableViewDelegate, LeftMenuDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSString *language;
@end

@implementation FITProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = [self.dishEntity localizedName];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor blackColor] duration:0.4f];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor whiteColor] duration:0.4f];
}

- (void)willReplaceViewController {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor whiteColor] duration:0.4f];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4 + self.dishEntity.products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    if (indexPath.row == 0) {
        FITProductImageTableViewCell *imageCell = [tableView dequeueReusableCellWithIdentifier:@"ProductImageCell" forIndexPath:indexPath];
        
        cell = imageCell;
    } else if (indexPath.row == 1) {
        FITProductDetailTableViewCell *detailCell = [tableView dequeueReusableCellWithIdentifier:@"ProductDetailCell" forIndexPath:indexPath];
        
        cell = detailCell;
    } else if (indexPath.row == 2) {
        FITProductTitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"ProductTitleCell" forIndexPath:indexPath];
        titleCell.label.text = NSLocalizedString(@"Products", nil);
        
        cell = titleCell;
    } else if (indexPath.row > 2 && indexPath.row < 2 + self.dishEntity.products.count) {
        FITProductInfoTableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"ProductInfoCell" forIndexPath:indexPath];
        
        FITProductEntity *product = self.dishEntity.products[indexPath.row - 3];
        if ([product isDataAvailable]) {
            [product fetchFromLocalDatastore];
        } else {
            [product fetchIfNeeded];
            [product pinInBackground];
        }
        
        infoCell.productLabel.text = [product localizedName];
        infoCell.sizeLabel.text = [NSString stringWithFormat:@"%@%@", product.size, [product localizedSuffix]];
        
        cell = infoCell;
    } else if (indexPath.row == 2 + self.dishEntity.products.count) {
        FITProductTitleTableViewCell *titleCell = [tableView dequeueReusableCellWithIdentifier:@"ProductTitleCell" forIndexPath:indexPath];
        titleCell.label.text = NSLocalizedString(@"Preparation", nil);
        
        cell = titleCell;
    } else if (indexPath.row == 3 + self.dishEntity.products.count) {
        FITProductLongTextTableViewCell *longCell = [tableView dequeueReusableCellWithIdentifier:@"ProductLongTextCell" forIndexPath:indexPath];
        
        longCell.label.text = [self.dishEntity localizedDescription];
    
        cell = longCell;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height;
    if (indexPath.row == 0) {
        height = 234.0f;
    } else if (indexPath.row == 1) {
        height = 102.0f;
    } else if (indexPath.row == 2 || indexPath.row == 2 + self.dishEntity.products.count) {
        height = 38.0f;
    } else if (indexPath.row > 2 && indexPath.row < 2 + self.dishEntity.products.count) {
        height = 36.0f;
    } else {
        NSDictionary *attributes = @{NSFontAttributeName: [UIFont systemFontOfSize:15.0f weight:UIFontWeightUltraLight]};
        CGRect rect = [[self.dishEntity localizedDescription] boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 16.0f, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
        
        height = rect.size.height + 40.0f;
    }
    
    return height;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
#if !(TARGET_IPHONE_SIMULATOR)
    NSUInteger offsetY = self.tableView.contentOffset.y;
    for (UITableViewCell *cell in self.tableView.visibleCells) {
        NSUInteger x = cell.contentView.frame.origin.x;
        NSUInteger w = cell.contentView.bounds.size.width;
        NSUInteger h = cell.contentView.bounds.size.height;
        NSUInteger y = ((offsetY - cell.frame.origin.y) / h) * 60;
        cell.contentView.frame = CGRectMake(x, y, w, h);
    }
#endif
}

@end
