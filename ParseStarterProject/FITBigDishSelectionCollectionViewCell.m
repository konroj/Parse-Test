//
//  FITBigDishSelectionCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBigDishSelectionCollectionViewCell.h"
#import "FITSmallDishSelectionCollectionViewCell.h"

@interface FITBigDishSelectionCollectionViewCell() <SmallDishSelectionDelegate>
@end

@implementation FITBigDishSelectionCollectionViewCell

- (void)awakeFromNib {
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dishList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FITSmallDishSelectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SmallDishSelectionCell" forIndexPath:indexPath];
    
    FITDishEntity *dish = self.dishList[indexPath.row];
    
    cell.nameLabel.text = [dish localizedName];
    cell.kcalLabel.text = [NSString stringWithFormat:@"%@ kCal", dish.kcal];
    cell.delegate = self;
    
    [cell.dishImageView setImageWithURL:[NSURL URLWithString:dish.photoUrl] placeholderImage:[UIImage imageNamed:@"breakfast"]];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    FITSmallDishSelectionCollectionViewCell *cell = (FITSmallDishSelectionCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
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

- (void)didSelectAddOption:(FITSmallDishSelectionCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    if ([self.delegate respondsToSelector:@selector(didSelectDishAdd:)]) {
        [self.delegate didSelectDishAdd:self.dishList[indexPath.row]];
    }
}

- (void)didSelectDetailOption:(FITSmallDishSelectionCollectionViewCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    
    if ([self.delegate respondsToSelector:@selector(didSelectDishDetail:)]) {
        [self.delegate didSelectDishDetail:self.dishList[indexPath.row]];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE_4_OR_LESS || IS_IPHONE_5) {
        return CGSizeMake(self.collectionView.frame.size.width / 1.7f, 210.0f);
    }
    return CGSizeMake(self.collectionView.frame.size.width / 2.3f, 210.0f);
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

@end
