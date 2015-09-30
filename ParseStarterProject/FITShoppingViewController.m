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

@interface FITShoppingViewController() <UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) M13OrderedDictionary *productsDictionary;
@property (strong, nonatomic) M13MutableOrderedDictionary *filteredDictionary;

@property (strong, nonatomic) FITShoppingListPresenter *presenter;
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
    
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        weakSelf.productsDictionary = [self.presenter fetchShoppingListForTommorow];
        weakSelf.filteredDictionary = [M13MutableOrderedDictionary orderedDictionaryWithOrderedDictionary:self.productsDictionary];
        dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf.tableView reloadData]; });
    });
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredDictionary.allKeys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    FITShoppingProductTableViewCell *cell = (FITShoppingProductTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    [cell showRightUtilityButtonsAnimated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FITShoppingHeaderView *view = [FITShoppingHeaderView new];
    view.backgroundColor = [UIColor colorWithHex:@"#2980b9"];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
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
    [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
