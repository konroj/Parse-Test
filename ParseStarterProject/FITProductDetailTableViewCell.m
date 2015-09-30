//
//  FITProductDetailTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITProductDetailTableViewCell.h"

@implementation FITProductDetailTableViewCell

- (void)awakeFromNib {
    UIImage *dotImage = [[UIImage imageNamed:@"dots"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.proteinImageView.image = dotImage;
    self.proteinImageView.tintColor = [UIColor colorWithHex:@"#d35400"];
    
    self.carboImageView.image = dotImage;
    self.carboImageView.tintColor = [UIColor colorWithHex:@"#2980b9"];
    
    self.fatImageView.image = dotImage;
    self.fatImageView.tintColor = [UIColor colorWithHex:@"#f39c12"];
    
    self.proteinLabel.text = NSLocalizedString(@"Protein", nil);
    self.carboLabel.text = NSLocalizedString(@"Carbohydrate", nil);
    self.fatLabel.text = NSLocalizedString(@"Fat", nil);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
