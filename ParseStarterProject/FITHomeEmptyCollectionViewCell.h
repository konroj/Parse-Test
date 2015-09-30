//
//  FITHomeEmptyCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 29.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITHomeEmptyCollectionViewCell;

@protocol HomeEmptyDelegate <NSObject>

- (void)didSelectPlanButton:(FITHomeEmptyCollectionViewCell *)cell;
- (void)didSelectChooseButton:(FITHomeEmptyCollectionViewCell *)cell;

@end

@interface FITHomeEmptyCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIImageView *planImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *planLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

@property (weak, nonatomic) id<HomeEmptyDelegate> delegate;

@end
