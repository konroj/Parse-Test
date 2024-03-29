//
//  FITHomeViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 25.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITHomeViewController.h"
#import "FITHomeCollectionViewCell.h"
#import "FITHomePresenter.h"
#import "FITProductDetailViewController.h"
#import "FITHomeEmptyCollectionViewCell.h"
#import "FITHomeShopCollectionViewCell.h"

static NSUInteger const ANIMATION_SPEED = 1.0f;
#define TRANSFORM_CELL_VALUE CGAffineTransformMakeScale(0.8, 0.8)

@interface FITHomeViewController () <UICollectionViewDataSource, UICollectionViewDelegate, HomeEmptyDelegate, HomeShopDelegate>
@property (weak, nonatomic) IBOutlet UILabel *kcalLabel;
@property (weak, nonatomic) IBOutlet UILabel *todayLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIButton *createButton;
@property (assign, nonatomic) BOOL isfirstTimeTransform;
@property (assign, nonatomic) NSUInteger currentCellIndex;

@property (strong, nonatomic) FITHomePresenter *presenter;
@property (strong, nonatomic) NSArray *dataList;

@property (assign, nonatomic) BOOL dataLoaded;
@property (assign, nonatomic) BOOL isDishTommorow;
@end

@implementation FITHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    [self addNavigationBarRight];
    
    self.isfirstTimeTransform = YES;
    self.currentCellIndex = 0;
    self.todayLabel.text = NSLocalizedString(@"Today", nil);
    
#ifdef DEBUG
    self.createButton.hidden = NO;
#else
    self.createButton.hidden = YES;
#endif
    
    self.presenter = [FITHomePresenter new];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dataLoaded = NO;
    self.kcalLabel.text = NSLocalizedString(@"Calculating...", nil);
    
    __weak __typeof__(self) weakSelf = self;
    [FITOperationQueue asyncOperation:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        NSArray *arrayDiet = [strongSelf.presenter fetchDiet];
        
        if (arrayDiet.count == 2) {
            strongSelf.dataList = [strongSelf dishArrayFromDayEntity:arrayDiet[0]];
            strongSelf.isDishTommorow = [strongSelf isDishInEntity:arrayDiet[1]];
            
            for (FITDishEntity *dish in strongSelf.dataList) {
                if ([dish isDataAvailable]) {
                    [dish fetchFromLocalDatastore];
                } else {
                    [dish fetchIfNeeded];
                    [PFObject pinAll:@[dish]];
                }
            }
        }
    } successful:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [strongSelf calculateTotalKcal];
        strongSelf.dataLoaded = YES;
        [strongSelf.collectionView reloadData];
    }];
}

- (void)viewDidAppear:(BOOL)animated {
    CGPoint p = CGPointMake(1, 1);
    struct CGPoint *pAqData = &p;
    [self scrollViewWillEndDragging:self.collectionView withVelocity:CGPointMake(1, 1) targetContentOffset:pAqData];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!self.dataLoaded) {
        return 0;
    } else if (!self.dataList.count && self.isDishTommorow) {
        return 1;
    }
    
    return self.dataList.count ?: 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.dataList.count && !self.isDishTommorow) {
        FITHomeEmptyCollectionViewCell *emptyCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeEmptyCell" forIndexPath:indexPath];
        emptyCell.delegate = self;
    
        return emptyCell;
    } else if (!self.dataList.count && self.isDishTommorow) {
        FITHomeShopCollectionViewCell *shopCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeShopCell" forIndexPath:indexPath];
        shopCell.delegate = self;
        
        return shopCell;
    }
    
    FITHomeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeCell" forIndexPath:indexPath];
    
    FITDishEntity *dish = self.dataList[indexPath.row];
    
    cell.topLabel.text = NSLocalizedString(dish.dishType, nil);
    cell.kcalLabel.text = [NSString stringWithFormat:@"%@ kCal", dish.kcal];
    cell.leftLabel.text = [NSString stringWithFormat:@"%@g", dish.protein];
    cell.middleLabel.text = [NSString stringWithFormat:@"%@g", dish.carbo];
    cell.rightLabel.text = [NSString stringWithFormat:@"%@g", dish.fat];
    cell.dishTitle.text = [dish localizedName];
    
    if (indexPath.item == self.currentCellIndex && self.isfirstTimeTransform) {
        self.isfirstTimeTransform = NO;
    } else {
        cell.transform = TRANSFORM_CELL_VALUE;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.dataLoaded || !self.dataList.count || (self.isDishTommorow && !self.dataList.count)) {
        return;
    }
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:FromHomeToProductDetailSegue sender:self.dataList[indexPath.row]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:FromHomeToProductDetailSegue]) {
        FITProductDetailViewController *vc = [segue destinationViewController];
        vc.dishEntity = sender;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (IS_IPHONE_4_OR_LESS) {
        return CGSizeMake(self.collectionView.frame.size.width - 100.0f, self.collectionView.frame.size.height - 5.0f);
    }
    
    return CGSizeMake(self.collectionView.frame.size.width - 70.0f, self.collectionView.frame.size.height - 5.0f);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    float pageWidth = self.collectionView.frame.size.width - 70.0f + 15.0f;
    
    if (IS_IPHONE_4_OR_LESS) {
        pageWidth = self.collectionView.frame.size.width - 100.0f + 15.0f;
    }
    
    float currentOffset = scrollView.contentOffset.x;
    float targetOffset = targetContentOffset->x;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset)
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    else
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    
    if (newTargetOffset < 0)
        newTargetOffset = 0;
    else if (newTargetOffset > scrollView.contentSize.width)
        newTargetOffset = scrollView.contentSize.width;
    
    targetContentOffset->x = currentOffset;
    [scrollView setContentOffset:CGPointMake(newTargetOffset, 0) animated:YES];
    
    int index = newTargetOffset / pageWidth;
    
    if (index == 0) {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index  inSection:0]];
        
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index + 1  inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    } else {
        UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = CGAffineTransformIdentity;
        }];
        
        index--;
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
        
        index++;
        index++;
        cell = [self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        [UIView animateWithDuration:ANIMATION_SPEED animations:^{
            cell.transform = TRANSFORM_CELL_VALUE;
        }];
    }
}

- (NSArray *)dishArrayFromDayEntity:(FITDayEntity *)day {
    NSMutableArray *mutableArray = [NSMutableArray new];

    if (day.breakfast) {
        [mutableArray addObject:day.breakfast];
    }
    if (day.secondBreakfast) {
        [mutableArray addObject:day.secondBreakfast];
    }
    if (day.lunch) {
        [mutableArray addObject:day.lunch];
    }
    if (day.snack) {
        [mutableArray addObject:day.snack];
    }
    if (day.dinner) {
        [mutableArray addObject:day.dinner];
    }
    
    return [NSArray arrayWithArray:mutableArray];
}

- (BOOL)isDishInEntity:(FITDayEntity *)day {
    BOOL isDish = NO;
    
    if (day.breakfast || day.secondBreakfast || day.lunch || day.snack || day.dinner) {
        isDish = YES;
    }
    
    return isDish;
}

- (void)calculateTotalKcal {
    NSInteger count = 0;
    
    for (FITDishEntity *dish in self.dataList) {
        count += dish.kcal.intValue;
    }
    
    self.kcalLabel.text = [NSString stringWithFormat:@"%d kCal", (int)count];
}

- (void)didSelectChooseButton:(FITHomeEmptyCollectionViewCell *)cell {
    [self performSegueWithIdentifier:FromHomeToSetSegue sender:nil];
}

- (void)didSelectPlanButton:(FITHomeEmptyCollectionViewCell *)cell {
    [self performSegueWithIdentifier:FromHomeToPlanSegue sender:nil];
}

- (void)didSelectShopListButton:(FITHomeShopCollectionViewCell *)cell {
    [self performSegueWithIdentifier:FromHomeToShopListSegue sender:nil];
}

- (void)didSelectChangePlanButton:(FITHomeShopCollectionViewCell *)cell {
    [self performSegueWithIdentifier:FromHomeToPlanSegue sender:nil];
}

@end
