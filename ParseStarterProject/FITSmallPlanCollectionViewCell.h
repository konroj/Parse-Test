//
//  FITSmallPlanCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITSmallPlanCollectionViewCell;

@protocol SmallPlanDelegate <NSObject>

- (void)didSelectRemoveOption:(FITSmallPlanCollectionViewCell *)cell;
- (void)didSelectEditOption:(FITSmallPlanCollectionViewCell *)cell;

@end

@interface FITSmallPlanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *dishLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UILabel *removeLabel;
@property (weak, nonatomic) IBOutlet UILabel *editLabel;

@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIImageView *removeImage;
@property (weak, nonatomic) IBOutlet UIImageView *editImage;
@property (weak, nonatomic) IBOutlet UIView *tapView;

@property (strong, nonatomic) UIImage *dishImage;

@property (weak, nonatomic) id<SmallPlanDelegate> delegate;

- (void)textForIndex:(NSIndexPath *)indexPath;

@end
