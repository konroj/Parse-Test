//
//  FITSelectionPresenter.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FITSelectionPresenter : UICollectionViewFlowLayout

- (NSDictionary *)fetchDishesWithIndex:(NSUInteger)index;

@end
