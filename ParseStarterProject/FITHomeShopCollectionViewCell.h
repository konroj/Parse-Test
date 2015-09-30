//
//  FITHomeShopCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 30.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FITHomeShopCollectionViewCell;

@protocol HomeShopDelegate <NSObject>

- (void)didSelectShopListButton:(FITHomeShopCollectionViewCell *)cell;
- (void)didSelectChangePlanButton:(FITHomeShopCollectionViewCell *)cell;

@end

@interface FITHomeShopCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIImageView *planImageView;
@property (weak, nonatomic) IBOutlet UIImageView *chooseImageView;
@property (weak, nonatomic) IBOutlet UILabel *planLabel;
@property (weak, nonatomic) IBOutlet UILabel *chooseLabel;

@property (weak, nonatomic) id<HomeShopDelegate> delegate;

@end
