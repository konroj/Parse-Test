//
//  FITLeftMenuTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITLeftMenuTableViewCell.h"

@implementation FITLeftMenuTableViewCell

- (void)awakeFromNib {
    self.label.textColor = [UIColor whiteColor];
}

- (void)leftImage:(NSString *)name {
    self.leftImage.image = [[UIImage imageNamed:name] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.leftImage.tintColor = [UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
