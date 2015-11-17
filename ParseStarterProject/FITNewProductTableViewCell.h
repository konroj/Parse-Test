//
//  FITNewProductTableViewCell.h
//  Fitsei
//
//  Created by Konrad Roj on 04.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NewProductDelegate <NSObject>

- (void)addNewProductCell:(id)sender;

@end

@interface FITNewProductTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UITextField *size;
@property (weak, nonatomic) IBOutlet UITextField *namePL;
@property (weak, nonatomic) IBOutlet UITextField *nameEN;
@property (weak, nonatomic) IBOutlet UITextField *suffixPL;
@property (weak, nonatomic) IBOutlet UITextField *suffixEN;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) id<NewProductDelegate> delegate;

@end
