//
//  FITHomeCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITHomeCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishTitle;
@property (weak, nonatomic) IBOutlet UIImageView *leftDot;
@property (weak, nonatomic) IBOutlet UIImageView *middleDot;
@property (weak, nonatomic) IBOutlet UIImageView *rightDot;
@property (weak, nonatomic) IBOutlet UILabel *leftLabel;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightLabel;

@end
