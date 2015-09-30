//
//  FITSmallDishSelectionCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 28.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITSmallDishSelectionCollectionViewCell;

@protocol SmallDishSelectionDelegate <NSObject>

- (void)didSelectAddOption:(FITSmallDishSelectionCollectionViewCell *)cell;
- (void)didSelectDetailOption:(FITSmallDishSelectionCollectionViewCell *)cell;

@end

@interface FITSmallDishSelectionCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (strong, nonatomic) UIImage *dishImage;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UILabel *addLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (weak, nonatomic) IBOutlet UIButton *detailButton;
@property (weak, nonatomic) IBOutlet UIImageView *plusImage;
@property (weak, nonatomic) IBOutlet UIImageView *detailImage;
@property (weak, nonatomic) IBOutlet UIView *tapView;

@property (weak, nonatomic) id<SmallDishSelectionDelegate> delegate;

@end
