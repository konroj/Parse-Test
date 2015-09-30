//
//  FITBigPlanCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBigPlanCollectionViewCell.h"
#import "FITSmallPlanCollectionViewCell.h"
#import "FITPlanViewController.h"
#import "FITEmptyPlanCollectionViewCell.h"

@interface FITBigPlanCollectionViewCell() <UICollectionViewDelegate, UICollectionViewDataSource, SmallPlanDelegate>

@end

@implementation FITBigPlanCollectionViewCell

- (void)awakeFromNib {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell;
    
    if ([self isEmptyForIndexPath:indexPath] || ![self.dayEntity.date isEqualToString:self.dayLabel.text]) {
        FITEmptyPlanCollectionViewCell *emptyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"EmptyPlanCell" forIndexPath:indexPath];
        
        [emptyCell textForIndex:indexPath];
        
        cell = emptyCell;
    } else {
        FITSmallPlanCollectionViewCell *smallCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallPlanCell" forIndexPath:indexPath];
        
        FITDishEntity *dish = [self dishForIndexPath:indexPath];
        smallCell.dishLabel.text = NSLocalizedString(dish.dishType, nil);
        smallCell.kcalLabel.text = [NSString stringWithFormat:@"%@ kCal", dish.kcal];
        smallCell.nameLabel.text = [dish localizedName];
        smallCell.delegate = self;
        
        [smallCell textForIndex:indexPath];
        
        cell = smallCell;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if ([cell isKindOfClass:[FITEmptyPlanCollectionViewCell class]]) {
        if ([self.delegate respondsToSelector:@selector(didSelectBigCell:smallIndexPath:)]) {
            [self.delegate didSelectBigCell:self smallIndexPath:indexPath];
        }
        
        [self.dayEntity pinInBackground];
    } else {
        FITSmallPlanCollectionViewCell *cell = (FITSmallPlanCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        if (cell.tapView.hidden) {
            [UIView transitionWithView:cell.contentView duration:.5 options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                cell.tapView.hidden = NO;
                cell.dishImageView.image = [UIImageEffects imageByApplyingBlurToImage:cell.dishImageView.image withRadius:60.0f tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
            } completion:nil];
        } else {
            [UIView transitionWithView:cell.contentView duration:.5 options:UIViewAnimationOptionTransitionFlipFromTop animations:^{
                cell.tapView.hidden = YES;
                cell.dishImageView.image = cell.dishImage;
            } completion:nil];
        }
    }
}

- (void)didSelectRemoveOption:(FITSmallPlanCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    switch (indexPath.row) {
        case 0: {
            self.dayEntity.breakfast = nil;
            break;
        }
        case 1: {
            self.dayEntity.secondBreakfast = nil;
            break;
        }
        case 2: {
            self.dayEntity.lunch = nil;
            break;
        }
        case 3: {
            self.dayEntity.snack = nil;
            break;
        }
        case 4: {
            self.dayEntity.dinner = nil;
            break;
        }
        default:
            break;
    }
    
    [self.dayEntity pinInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self.collectionView reloadData];
    }];
}

- (void)didSelectEditOption:(FITSmallPlanCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if ([self.delegate respondsToSelector:@selector(didSelectBigCell:smallIndexPath:)]) {
        [self.delegate didSelectBigCell:self smallIndexPath:indexPath];
    }
    
    [self.dayEntity pinInBackground];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        return CGSizeMake(self.collectionView.frame.size.width / 1.7f, 211.0f);
    }
    return CGSizeMake(self.collectionView.frame.size.width / 2.3f, 211.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0.0f, 5.0f, 0.0f, 5.0f);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    float pageWidth = (self.collectionView.frame.size.width / 2.3f) + 5.0f;
    
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        pageWidth = (self.collectionView.frame.size.width / 1.7f) + 5.0f;
    }
    
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
}

- (BOOL)isEmptyForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return !self.dayEntity.breakfast;
    } else if (indexPath.item == 1) {
        return !self.dayEntity.secondBreakfast;
    } else if (indexPath.item == 2) {
        return !self.dayEntity.lunch;
    } else if (indexPath.item == 3) {
        return !self.dayEntity.snack;
    } else if (indexPath.item == 4) {
        return !self.dayEntity.dinner;
    }
    
    return YES;
}

- (FITDishEntity *)dishForIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0) {
        return self.dayEntity.breakfast;
    } else if (indexPath.item == 1) {
        return self.dayEntity.secondBreakfast;
    } else if (indexPath.item == 2) {
        return self.dayEntity.lunch;
    } else if (indexPath.item == 3) {
        return self.dayEntity.snack;
    } else if (indexPath.item == 4) {
        return self.dayEntity.dinner;
    }
    
    return nil;
}

@end
