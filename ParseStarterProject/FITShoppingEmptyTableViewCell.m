//
//  FITShoppingEmptyTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 30.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITShoppingEmptyTableViewCell.h"

@implementation FITShoppingEmptyTableViewCell

- (void)awakeFromNib {
    self.label.text = NSLocalizedString(@"We present a shopping list for tomorrow or next week. The range can be changed in the settings.", nil);
    
    self.headerLabel.text = NSLocalizedString(@"Nothing to buy", nil);
    
    self.leftImageView.image = [[UIImage imageNamed:@"boo"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.leftImageView.tintColor = [UIColor whiteColor];
}

@end
