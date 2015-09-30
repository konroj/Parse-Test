//
//  FITSmallPlanCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSmallPlanCollectionViewCell.h"


@implementation FITSmallPlanCollectionViewCell

- (void)awakeFromNib {
    self.removeLabel.text = NSLocalizedString(@"REMOVE", nil);
    self.editLabel.text = NSLocalizedString(@"EDIT", nil);
    
    self.removeImage.image = [[UIImage imageNamed:@"delete"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.removeImage.tintColor = [UIColor whiteColor];
    
    self.editImage.image = [[UIImage imageNamed:@"edit"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.editImage.tintColor = [UIColor whiteColor];
    
    self.dishImage = [UIImage imageNamed:@"breakfast"];
    self.dishImageView.image = self.dishImage;
    
    self.tapView.hidden = YES;
}

- (void)textForIndex:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            self.dishLabel.text = NSLocalizedString(@"Breakfast", nil);
            break;
        }
        case 1: {
            self.dishLabel.text = NSLocalizedString(@"Second breakfast", nil);
            break;
        }
        case 2: {
            self.dishLabel.text = NSLocalizedString(@"Lunch", nil);
            break;
        }
        case 3: {
            self.dishLabel.text = NSLocalizedString(@"Snack", nil);
            break;
        }
        case 4: {
            self.dishLabel.text = NSLocalizedString(@"Dinner", nil);
            break;
        }
        default:
            break;
    }
}

- (IBAction)removeAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectRemoveOption:)]) {
        [self.delegate didSelectRemoveOption:self];
    }
}

- (IBAction)editAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(didSelectEditOption:)]) {
        [self.delegate didSelectEditOption:self];
    }
}

@end
