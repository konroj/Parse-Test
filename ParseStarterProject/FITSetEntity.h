//
//  FITSetEntity.h
//  Fitsei
//
//  Created by Konrad Roj on 02.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "PFObject.h"

@interface FITSetEntity : PFObject <PFSubclassing>

@property (strong, nonatomic) NSArray *days;

@end
