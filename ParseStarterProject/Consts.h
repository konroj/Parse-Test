//
//  Consts.h
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#ifndef Consts_h
#define Consts_h

#define FITMainViewController (FITDrawerViewController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController]
#define FITNavigationController (UINavigationController *)[(FITDrawerViewController *)[[(AppDelegate *)[[UIApplication sharedApplication] delegate] window] rootViewController] rootViewController]

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

static NSString * _Nonnull FromHomeToProductDetailSegue = @"FromHomeToProductDetailSegue";
static NSString * _Nonnull FromPlanToDishSelectionSegue = @"FromPlanToDishSelectionSegue";
static NSString * _Nonnull FromDishSelectionToProductDetailSegue = @"FromDishSelectionToProductDetailSegue";
static NSString * _Nonnull FromHomeToPlanSegue = @"FromHomeToPlanSegue";
static NSString * _Nonnull FromHomeToShopListSegue = @"FromHomeToShopListSegue";

#endif /* Consts_h */
