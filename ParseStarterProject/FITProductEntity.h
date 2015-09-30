//
//  FITProductEntity.h
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "PFObject.h"

@interface FITProductEntity : PFObject <PFSubclassing>

@property (strong, nonatomic) NSString *dishNameEN;

@property (strong, nonatomic) NSString *namePL;
@property (strong, nonatomic) NSString *nameEN;
@property (strong, nonatomic) NSNumber *size;
@property (strong, nonatomic) NSString *suffixPL;
@property (strong, nonatomic) NSString *suffixEN;
@property (strong, nonatomic) NSString *suffixImperial;

- (NSString *)localizedName;
- (NSString *)localizedSuffix;

@end
