//
//  FITLogoTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITLogoTableViewCell.h"

@implementation FITLogoTableViewCell

- (void)awakeFromNib {
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
