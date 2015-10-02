//
//  FITSetTableViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 01.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITSetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *leftKcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

+ (CGFloat)cellHeight;

@end
