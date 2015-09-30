//
//  FITSmallDishSelectionCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 28.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSmallDishSelectionCollectionViewCell.h"

@interface FITSmallDishSelectionCollectionViewCell () <UIGestureRecognizerDelegate>

@end

@implementation FITSmallDishSelectionCollectionViewCell

- (void)awakeFromNib {
    self.addLabel.text = NSLocalizedString(@"ADD", nil);
    self.detailLabel.text = NSLocalizedString(@"DETAIL", nil);
    
    self.plusImage.image = [[UIImage imageNamed:@"plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.plusImage.tintColor = [UIColor whiteColor];
    
    self.detailImage.image = [[UIImage imageNamed:@"detail"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.detailImage.tintColor = [UIColor whiteColor];
    
    self.tapView.hidden = YES;
    
    self.dishImage = [UIImage imageNamed:@"breakfast"];
    self.dishImageView.image = self.dishImage;
}

- (IBAction)addAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectAddOption:)]) {
        [self.delegate didSelectAddOption:self];
    }
}

- (IBAction)detailAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectDetailOption:)]) {
        [self.delegate didSelectDetailOption:self];
    }
}


@end
