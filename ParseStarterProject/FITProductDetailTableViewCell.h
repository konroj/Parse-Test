//
//  FITProductDetailTableViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITProductDetailTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *proteinImageView;
@property (weak, nonatomic) IBOutlet UIImageView *carboImageView;
@property (weak, nonatomic) IBOutlet UIImageView *fatImageView;
@property (weak, nonatomic) IBOutlet UILabel *proteinSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *carboSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fatSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;

@property (weak, nonatomic) IBOutlet UILabel *proteinLabel;
@property (weak, nonatomic) IBOutlet UILabel *carboLabel;
@property (weak, nonatomic) IBOutlet UILabel *fatLabel;

@end
