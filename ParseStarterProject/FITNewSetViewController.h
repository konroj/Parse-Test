//
//  FITNewSetViewController.h
//  Fitsei
//
//  Created by Konrad Roj on 04.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITBaseViewController.h"

@interface FITNewSetViewController : FITBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *namePL;
@property (weak, nonatomic) IBOutlet UITextField *nameEN;
@property (weak, nonatomic) IBOutlet UITextField *descriptionPL;
@property (weak, nonatomic) IBOutlet UITextField *descriptionEN;
@property (weak, nonatomic) IBOutlet UITextField *kcal;

@end
