//
//  FITNewProductTableViewCell.m
//  Fitsei
//
//  Created by Konrad Roj on 04.10.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITNewProductTableViewCell.h"

@implementation FITNewProductTableViewCell

- (IBAction)addProductCellAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(addNewProductCell:)]) {
        [self.delegate addNewProductCell:self];
    }
}

@end
