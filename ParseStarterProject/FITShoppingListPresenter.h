//
//  FITShoppingListPresenter.h
//  Fitsei
//
//  Created by Konrad Roj on 28.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FITShoppingListPresenter : NSObject

- (M13OrderedDictionary *)fetchShoppingListForThisWeek;
- (M13OrderedDictionary *)fetchShoppingListForNextWeek;
- (M13OrderedDictionary *)fetchShoppingListForToday;
- (M13OrderedDictionary *)fetchShoppingListForTommorow;

@end
