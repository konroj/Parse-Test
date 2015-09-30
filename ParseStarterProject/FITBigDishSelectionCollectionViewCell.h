//
//  FITBigDishSelectionCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITBigDishSelectionCollectionViewCell;

@protocol FITBigDishSelectionDelegate <NSObject>

- (void)didSelectDishDetail:(FITDishEntity *)dish;
- (void)didSelectDishAdd:(FITDishEntity *)dish;

@end

@interface FITBigDishSelectionCollectionViewCell : UICollectionViewCell <UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) id<FITBigDishSelectionDelegate> delegate;
@property (strong, nonatomic) NSArray *dishList;

@end
