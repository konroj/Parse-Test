//
//  FITSettingsTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITSettingsTableViewCell.h"

@implementation FITSettingsTableViewCell

- (void)awakeFromNib {
    [self.control removeAllSegments];
    self.control.tintColor = [UIColor blackColor];//[UIColor colorWithHex:@"#cac13b"];
    self.backgroundColor = [UIColor clearColor];
}

- (void)controlWithTitles:(NSString *)firstTitle second:(NSString *)secondTitle {
    [self.control removeAllSegments];
    [self.control insertSegmentWithTitle:NSLocalizedString(firstTitle, nil) atIndex:0 animated:NO];
    [self.control insertSegmentWithTitle:NSLocalizedString(secondTitle, nil) atIndex:1 animated:NO];
}

@end
