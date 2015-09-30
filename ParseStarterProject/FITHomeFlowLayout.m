//
//  FITHomeFlowLayout.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomeFlowLayout.h"

@implementation FITHomeFlowLayout

- (void)awakeFromNib {
    self.itemSize = CGSizeMake(self.collectionView.frame.size.width - 70.0f, self.collectionView.frame.size.height - 5.0f);
    if (IS_IPHONE_4_OR_LESS) {
        self.itemSize = CGSizeMake(self.collectionView.frame.size.width - 100.0f, self.collectionView.frame.size.height - 5.0f);
    }
    self.minimumInteritemSpacing = 15;
    self.minimumLineSpacing = 15;
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.sectionInset = UIEdgeInsetsMake(0, 5, 0, 5);
}

@end
