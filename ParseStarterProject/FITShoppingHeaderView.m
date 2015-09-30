//
//  FITShoppingHeaderView.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITShoppingHeaderView.h"

@implementation FITShoppingHeaderView

- (void)initialize {
    self.textLabel = [UILabel new];
    self.textLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightUltraLight];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.text = NSLocalizedString(@"Need for tommorow", nil);
    [self addSubview:self.textLabel];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
    }];
}

- (id)initWithCoder:(NSCoder *)aCoder{
    if(self = [super initWithCoder:aCoder]){
        [self initialize];
    }
    return self;
}

- (id)initWithFrame:(CGRect)rect{
    if(self = [super initWithFrame:rect]){
        [self initialize];
    }
    return self;
}

@end
