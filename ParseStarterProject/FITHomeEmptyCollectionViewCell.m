//
//  FITHomeEmptyCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 29.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomeEmptyCollectionViewCell.h"

@implementation FITHomeEmptyCollectionViewCell

- (void)awakeFromNib {
    self.topLabel.text = NSLocalizedString(@"Not hungry?", nil);
    self.planLabel.text = NSLocalizedString(@"PLAN YOUR DIET", nil);
    self.chooseLabel.text = NSLocalizedString(@"CHOOSE STANDARD PLAN", nil);
    
    UIImage *plan = [[UIImage imageNamed:@"plan"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *choose = [[UIImage imageNamed:@"choose"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.planImageView.image = plan;
    self.chooseImageView.image = choose;
    
    self.planImageView.tintColor = [UIColor whiteColor];
    self.chooseImageView.tintColor = [UIColor whiteColor];
}

- (IBAction)planButtonAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectPlanButton:)]) {
        [self.delegate didSelectPlanButton:self];
    }
}

- (IBAction)chooseAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectChooseButton:)]) {
        [self.delegate didSelectChooseButton:self];
    }
}

@end
