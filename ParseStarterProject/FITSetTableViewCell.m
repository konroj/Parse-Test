//
//  FITSetTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 01.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSetTableViewCell.h"

@implementation FITSetTableViewCell

- (void)awakeFromNib {
    self.leftImageView.image = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:@"breakfast"] withRadius:50.0f tintColor:nil saturationDeltaFactor:1.0f maskImage:nil];
}

+ (CGFloat)cellHeight {
    return 140.0f;
}

@end
