//
//  FITEmptyPlanCollectionViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITEmptyPlanCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
@property (weak, nonatomic) IBOutlet UILabel *dishLabel;

- (void)textForIndex:(NSIndexPath *)indexPath;

@end
