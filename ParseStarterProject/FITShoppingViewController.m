//
//  FITShoppingViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITShoppingViewController.h"
#import "FITShoppingProductTableViewCell.h"
#import "FITShoppingHeaderView.h"
#import "FITShoppingListPresenter.h"
#import "FITShoppingEmptyTableViewCell.h"

@interface FITShoppingViewController() <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) M13OrderedDictionary *productsDictionary;
@property (strong, nonatomic) M13MutableOrderedDictionary *filteredDictionary;
@property (strong, nonatomic) FITShoppingListPresenter *presenter;
@property (assign, nonatomic) BOOL isLoading;
@property (assign, nonatomic) BOOL deletingLastCell;
@end

@implementation FITShoppingViewController

- (void)awakeFromNib {
    [self addNavigationBarRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, 20.0f, 0.0f);
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    self.presenter = [FITShoppingListPresenter new];
    
    self.isLoading = YES;
    
    __weak __typeof__(self) weakSelf = self;
    [FITOperationQueue asyncOperation:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        strongSelf.productsDictionary = [strongSelf.presenter fetchShoppingListForTommorow];
        strongSelf.filteredDictionary = [M13MutableOrderedDictionary orderedDictionaryWithOrderedDictionary:strongSelf.productsDictionary];
    } successful:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        strongSelf.isLoading = NO;
        [strongSelf.tableView reloadData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isLoading) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredDictionary.allKeys.count ?: !self.deletingLastCell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.filteredDictionary.allKeys.count && !self.isLoading) {
        FITShoppingEmptyTableViewCell *emptyCell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingEmptyCell" forIndexPath:indexPath];
        return emptyCell;
    }
    
    FITShoppingProductTableViewCell *productCell = [tableView dequeueReusableCellWithIdentifier:@"ShoppingProductCell" forIndexPath:indexPath];
    productCell.rightUtilityButtons = [self rightButtons];
    productCell.delegate = self;
    
    NSString *product = self.filteredDictionary.allKeys[indexPath.row];
    NSArray *data = self.filteredDictionary[product];
    
    productCell.productLabel.text = data[0];
    productCell.sizeLabel.text = [NSString stringWithFormat:@"%@ %@", data[1], data[2]];
    
    return productCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.filteredDictionary.allKeys.count && !self.isLoading) {
        return;
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FITShoppingProductTableViewCell *cell = (FITShoppingProductTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell showRightUtilityButtonsAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.filteredDictionary.allKeys.count && !self.isLoading) {
        return 280.0f;
    }
    return 64.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (!self.filteredDictionary.allKeys.count && !self.isLoading) {
        return [UIView new];
    }
    FITShoppingHeaderView *view = [FITShoppingHeaderView new];
    view.backgroundColor = [UIColor colorWithHex:@"#2980b9"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (!self.filteredDictionary.allKeys.count && !self.isLoading) {
        return CGFLOAT_MIN;
    }
    return 18.0f;
}

- (NSArray *)rightButtons {
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithHex:@"#2980b9"] title:@"Got it"];
    
    return rightUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    [self.filteredDictionary removeEntryAtIndex:indexPath.row];
    self.deletingLastCell = YES;
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    if (!self.filteredDictionary.count) {
        self.deletingLastCell = NO;
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView reloadData];
    }
}

@end
