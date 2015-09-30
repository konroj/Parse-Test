//
//  FITHomeCollectionViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomeCollectionViewCell.h"

@implementation FITHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UIImage *dotImage = [[UIImage imageNamed:@"dots"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    
    self.leftDot.image = dotImage;
    self.leftDot.tintColor = [UIColor colorWithHex:@"#d35400"];
    
    self.middleDot.image = dotImage;
    self.middleDot.tintColor = [UIColor colorWithHex:@"#2980b9"];
    
    self.rightDot.image = dotImage;
    self.rightDot.tintColor = [UIColor colorWithHex:@"#f39c12"];
}

- (void)setSelected:(BOOL)selected {
    if (selected) {
        self.cardView.backgroundColor = [UIColor lightGrayColor];
    } else {
        self.cardView.backgroundColor = [UIColor whiteColor];
    }
}

@end
