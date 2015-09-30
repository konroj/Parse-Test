//
//  FITEmptyPlanCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITEmptyPlanCollectionViewCell.h"

@implementation FITEmptyPlanCollectionViewCell

- (void)awakeFromNib {
    self.emptyLabel.text = NSLocalizedString(@"Tap to choose", nil);
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

@end
