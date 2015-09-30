//
//  FITDishSelectionViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITDishSelectionViewController.h"
#import "FITBigDishSelectionCollectionViewCell.h"
#import "FITNavigationViewController.h"
#import "FITLeftMenuViewController.h"
#import "FITRightMenuViewController.h"
#import "FITDrawerViewController.h"
#import "FITDietPlanPresenter.h"
#import "FITSelectionPresenter.h"
#import "FITProductDetailViewController.h"
#import "FITPlanViewController.h"

@interface FITDishSelectionViewController () <UICollectionViewDataSource, UICollectionViewDelegate, FITBigDishSelectionDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) BOOL colorSet;

@property (strong, nonatomic) NSDictionary *dishesDictionary;

@property (strong, nonatomic) FITSelectionPresenter *presenter;
@end

@implementation FITDishSelectionViewController

- (void)awakeFromNib {
    [self addNavigationBarRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"Selection", nil);
    self.view.backgroundColor = [UIColor colorWithHex:@"#d52291"];
    
    self.presenter = [FITSelectionPresenter new];
    
    self.dishesDictionary = [self.presenter fetchDishesWithIndex:self.index];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dishesDictionary.allKeys.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FITBigDishSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigDishSelectionCell" forIndexPath:indexPath];
    
    NSString *title = self.dishesDictionary.allKeys[indexPath.row];
    cell.dayLabel.text = NSLocalizedString(title, nil);
    
    NSArray *dishList = self.dishesDictionary[title];
    cell.dishList = dishList;
    
    cell.delegate = self;
    
    return cell;
}

- (void)didSelectDishDetail:(FITDishEntity *)dish {
    [self performSegueWithIdentifier:FromDishSelectionToProductDetailSegue sender:dish];
}

- (void)didSelectDishAdd:(FITDishEntity *)dish {
    switch (self.index) {
        case 0: {
            self.dayEntity.breakfast = dish;
            break;
        }
        case 1: {
            self.dayEntity.secondBreakfast = dish;
            break;
        }
        case 2: {
            self.dayEntity.lunch = dish;
            break;
        }
        case 3: {
            self.dayEntity.snack = dish;
            break;
        }
        case 4: {
            self.dayEntity.dinner = dish;
            break;
        }
        default:
            break;
    }
    
    [self.dayEntity pinInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self.planController reloadPlanView];
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    FITProductDetailViewController *vc = segue.destinationViewController;
    vc.dishEntity = sender;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, 250.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(6.0f, 0.0f, 25.0f, 0.0f);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    float pageWidth = 260.0f;
    
    float currentOffset = scrollView.contentOffset.y;
    float targetOffset = targetContentOffset->y;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset) {
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    } else {
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    }
    
    if (newTargetOffset == 0 || newTargetOffset < 0) {
        [UIView animateWithDuration:0.2f animations:^{
            self.background.alpha = 1.0f;
        }];
        
    } else if (newTargetOffset >= 1 && !self.colorSet) {
        [UIView animateWithDuration:0.2f animations:^{
            self.background.alpha = 0.0f;
        }];
    }
    
    if (newTargetOffset < 0) {
        newTargetOffset = 0;
    } else if (newTargetOffset > scrollView.contentSize.height) {
        newTargetOffset = scrollView.contentSize.height;
    }
    
    targetContentOffset->y = currentOffset;
    [scrollView setContentOffset:CGPointMake(0, newTargetOffset) animated:YES];
}

@end
