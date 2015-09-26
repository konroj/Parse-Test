//
//  FITHomeViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomeViewController.h"
#import "FITHomeCollectionViewCell.h"

static NSUInteger const ANIMATION_SPEED = 1.0f;
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.8, 0.8)

@interface FITHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (assign, nonatomic) BOOL isfirstTimeTransform;
@property (assign, nonatomic) NSUInteger currentCellIndex;
@end

@implementation FITHomeViewController

- (void)awakeFromNib {
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addNavigationBarRight];

    self.isfirstTimeTransform = YES;
    self.currentCellIndex = 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FITHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    switch (indexPath.row) {
        case 0: {
            cell.topLabel.text = NSLocalizedString(@"Breakfast", nil);
            break;
        }
        case 1: {
            cell.topLabel.text = NSLocalizedString(@"Lunch", nil);
            break;
        }
        case 2: {
            cell.topLabel.text = NSLocalizedString(@"Snack", nil);
            break;
        }
        case 3: {
            cell.topLabel.text = NSLocalizedString(@"Dinner", nil);
            break;
        }
        case 4: {
            cell.topLabel.text = NSLocalizedString(@"Supper", nil);
            break;
        }
        default:
            break;
    }
    
    if (indexPath.item == self.currentCellIndex && self.isfirstTimeTransform) {
        self.isfirstTimeTransform = NO;
    } else {
        cell.transform = TRANSFORM_CELL_VALUE;
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width - 70.0f, self.collectionView.frame.size.height - 5.0f);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    float pageWidth = self.collectionView.frame.size.width - 70.0f + 15.0f;
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    int index = newTargetOffset / pageWidth;
    
    if (index == 0) { // If first index
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index  inSection:0]];
        
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    } else {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        
        index --; // left
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
        
        index ++;
        index ++; // right
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }
}

- (IBAction)shopListButtonAction:(id)sender {
    
}

@end
