//
//  FITHomePresenter.m
//  Fitsei
//
//  Created by Konrad Roj on 27.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomePresenter.h"

@implementation FITHomePresenter

- (FITDayEntity *)fetchTodayDiet {
    PFQuery *query = [PFQuery queryWithClassName:@"Day"];
    [query fromLocalDatastore];
    
    [query whereKey:@"date" equalTo:[self stringFromDate:[NSDate date]]];
    
    return [query findObjects].firstObject;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"EEEE, d MMMM"];
    
    [formatter setTimeZone:[NSTimeZone systemTimeZone]];
    
    return [formatter stringFromDate:date];
}

- (void)addRandomObject {
    FITDishEntity *dish = [self prepareDish];
    
    FITProductEntity *product1 = [FITProductEntity objectWithClassName:@"Product"];
    FITProductEntity *product2 = [FITProductEntity objectWithClassName:@"Product"];
    FITProductEntity *product3 = [FITProductEntity objectWithClassName:@"Product"];
    
    product1.dishNameEN = dish.nameEN;
    product1.nameEN = @"Chicken breast";
    product1.namePL = @"Pierś z kurczaka";
    product1.size = @(240);
    product1.suffixPL = @"gram";
    product1.suffixEN = @"g";
    product1.suffixImperial = @"lb";
    
    product2.dishNameEN = dish.nameEN;
    product2.nameEN = @"Potatoes";
    product2.namePL = @"Ziemniaki";
    product2.size = @(1);
    product2.suffixPL = @"kg";
    product2.suffixEN = @"kg";
    product2.suffixImperial = @"lb";
    
    product3.dishNameEN = dish.nameEN;
    product3.nameEN = @"Tomatoes";
    product3.namePL = @"Pomidory";
    product3.size = @(2);
    product3.suffixPL = @"sztuki";
    product3.suffixEN = @"pieces";
    product3.suffixImperial = @"pieces";
    
    dish.products = [NSArray arrayWithObjects:product1, product2, product3, nil];
    
    [dish save];
}

- (FITDishEntity *)prepareDish {
    FITDishEntity *dish = [FITDishEntity objectWithClassName:@"Dish"];
    
    dish.dishType = @"Lunch";
    dish.foodType = @"Meat";
    
    dish.namePL = @"Kotlet w panierce bezglutenowej";
    dish.nameEN = @"Cutlet breaded gluten-free";
    
    dish.photoUrl = @"http://www.spirefarmtofork.com/assets/images/food_plate2.png";
    
    dish.descriptionPL = @"Umyte plastry schabu lub piersi z kurczaka roztłuc tłuczkiem na dowolną grubość w zależności od upodobań. (Uważać, aby mięso się nie porwało i nie zrobiły się w nim dziury. Można mięso włożyć do woreczka foliowego, wówczas nie będzie pryskać).";
    
    dish.descriptionEN = @"Washed slices of pork loin or chicken breast roztłuc pestle on any thickness depending on your preference. (Make sure that the meat is not hijacked and made a hole in it. You put the meat into plastic bag, then there will sputter).";
    
    dish.protein = @(13.2);
    dish.carbo = @(11.1);
    dish.fat = @(4.5);
    dish.kcal = @(510);
    
    return dish;
}

@end
