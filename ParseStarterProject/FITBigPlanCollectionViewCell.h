//
//  FITBigPlanCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITBigPlanCollectionViewCell;
@class FITPlanViewController;

@protocol BigCollectionCellDelegate <NSObject>

- (void)didSelectBigCell:(FITBigPlanCollectionViewCell *)cell smallIndexPath:(NSIndexPath *)indexPath;

@end

@interface FITBigPlanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id<BigCollectionCellDelegate> delegate;
@property (weak, nonatomic) FITPlanViewController *planViewController;

@property (strong, nonatomic) FITDayEntity *dayEntity;

@end
