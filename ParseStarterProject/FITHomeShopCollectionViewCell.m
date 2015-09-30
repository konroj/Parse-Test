//
//  FITHomeShopCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 30.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomeShopCollectionViewCell.h"

@implementation FITHomeShopCollectionViewCell

- (void)awakeFromNib {
    self.topLabel.text = NSLocalizedString(@"Ready for tommorow?", nil);
    self.planLabel.text = NSLocalizedString(@"SHOPPING LIST", nil);
    self.chooseLabel.text = NSLocalizedString(@"CHANGE YOUR PLAN", nil);
    
    UIImage *plan = [[UIImage imageNamed:@"shop"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *choose = [[UIImage imageNamed:@"plan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.planImageView.image = plan;
    self.chooseImageView.image = choose;
    
    self.planImageView.tintColor = [UIColor whiteColor];
    self.chooseImageView.tintColor = [UIColor whiteColor];
}

- (IBAction)planButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectShopListButton:)]) {
        [self.delegate didSelectShopListButton:self];
    }
}

- (IBAction)chooseAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectChangePlanButton:)]) {
        [self.delegate didSelectChangePlanButton:self];
    }
}

@end
