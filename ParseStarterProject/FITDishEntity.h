//
//  FITDishEntity.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "PFObject.h"

@interface FITDishEntity : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *foodType;
@property (strong, nonatomic) NSString *dishType;

@property (strong, nonatomic) NSString *namePL;
@property (strong, nonatomic) NSString *nameEN;

@property (strong, nonatomic) NSString *photoUrl;

@property (strong, nonatomic) NSString *descriptionPL;
@property (strong, nonatomic) NSString *descriptionEN;

@property (strong, nonatomic) NSNumber *protein;
@property (strong, nonatomic) NSNumber *carbo;
@property (strong, nonatomic) NSNumber *fat;
@property (strong, nonatomic) NSNumber *kcal;

@property (strong, nonatomic) NSArray *products;

- (NSString *)localizedName;
- (NSString *)localizedDescription;

@end
