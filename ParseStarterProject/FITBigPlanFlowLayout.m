//
//  FITBigPlanFlowLayout.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBigPlanFlowLayout.h"

@implementation FITBigPlanFlowLayout

- (void)awakeFromNib {
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width, 250.0f);
    self.minimumInteritemSpacing = 0;
    self.minimumLineSpacing = 0;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.sectionInset = UIEdgeInsetsMake(70.0f, 0.0f, 25.0f, 0.0f);
}

@end
