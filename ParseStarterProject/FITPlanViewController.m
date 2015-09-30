//
//  FITPlanViewController.m
//  Fitsei
//
//  Created by Konrad Roj on 26.09.2015.
//  Copyright © 2015 Konrad Roj. All rights reserved.
//

#import "FITPlanViewController.h"
#import "FITBigPlanCollectionViewCell.h"
#import "FITNavigationViewController.h"
#import "FITLeftMenuViewController.h"
#import "FITRightMenuViewController.h"
#import "FITDrawerViewController.h"
#import "FITDietPlanPresenter.h"
#import "FITDishSelectionViewController.h"

@interface FITPlanViewController() <UICollectionViewDataSource, UICollectionViewDelegate, LeftMenuDelegate, RightMenuDelegate, BigCollectionCellDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIImageView *background;
@property (assign, nonatomic) NSInteger currentPage;
@property (assign, nonatomic) BOOL colorSet;
@property (strong, nonatomic) FITDietPlanPresenter *presenter;
@end

@implementation FITPlanViewController

- (void)awakeFromNib {
    ((FITDrawerViewController *)FITMainViewController).leftViewController.delegate = self;
    ((FITDrawerViewController *)FITMainViewController).rightViewController.delegate = self;
    [self addTwoBarRight];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.presenter = [FITDietPlanPresenter new];
    [self loadDatesForWeek:0];
    
    self.view.backgroundColor = [UIColor colorWithHex:@"#41c0c0"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dayList = [self.presenter fetchDietPlanForDates:self.dates];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor blackColor] duration:0.4f];
    
    [self.collectionView reloadData];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.dates.count) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:[self currentDayIndex] inSection:0];
        
        CGPoint proposedOffset = CGPointMake(0, 0);
        proposedOffset.y = indexPath.item * (250.0f + 10.0f);
        [self.collectionView setContentOffset:proposedOffset animated:YES];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *visibleCells = [self.collectionView visibleCells];
    BOOL topVisible;
    for (UICollectionViewCell *cell in visibleCells) {
        if ([[self.collectionView indexPathForCell:cell] isEqual:[NSIndexPath indexPathForItem:0 inSection:0]]) {
            topVisible = YES;
        }
    }
    
    if (!topVisible) {
        [((FITNavigationViewController *)self.navigationController) animateNavigationBarFromColor:[UIColor clearColor] toColor:[UIColor colorWithHex:@"#41c0c0"] duration:0.4f];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dates.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FITBigPlanCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BigPlanCell" forIndexPath:indexPath];
    
    NSDate *date = self.dates[indexPath.item];
    NSString *key = [self.presenter stringFromDate:date];
    
    cell.dayLabel.text = key;
    cell.dayEntity = self.dayList[indexPath.item];
    cell.delegate = self;
    cell.planViewController = self;
    
    [cell.collectionView reloadData];
    
    return cell;
}

- (void)didSelectBigCell:(FITBigPlanCollectionViewCell *)cell smallIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:FromPlanToDishSelectionSegue sender:@[cell.dayEntity, indexPath]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSArray *array = sender;
    
    FITDishSelectionViewController *vc = segue.destinationViewController;
    vc.planController = self;
    vc.dayEntity = array.firstObject;
    vc.index = ((NSIndexPath *)array[1]).item;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, 250.0f);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(70.0f, 0.0f, 25.0f, 0.0f);
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    
    float pageWidth = 260.0f;
    
    float currentOffset = scrollView.contentOffset.y;
    float targetOffset = targetContentOffset->y;
    float newTargetOffset = 0;
    
    if (targetOffset > currentOffset) {
        newTargetOffset = ceilf(currentOffset / pageWidth) * pageWidth;
    } else {
        newTargetOffset = floorf(currentOffset / pageWidth) * pageWidth;
    }
    
    if (newTargetOffset == 0 || newTargetOffset < 0) {
        [((FITNavigationViewController *)self.navigationController) animateNavigationBarFromColor:[UIColor colorWithHex:@"#41c0c0"] toColor:[UIColor clearColor] duration:0.4f];
        self.colorSet = NO;
        
        [UIView animateWithDuration:0.2f animations:^{
            self.background.alpha = 1.0f;
        }];
        
    } else if (newTargetOffset >= 1 && !self.colorSet) {
        [((FITNavigationViewController *)self.navigationController) animateNavigationBarFromColor:[UIColor clearColor] toColor:[UIColor colorWithHex:@"#41c0c0"] duration:0.4f];
        self.colorSet = YES;
        
        [UIView animateWithDuration:0.2f animations:^{
            self.background.alpha = 0.0f;
        }];
    }
    
    if (newTargetOffset < 0) {
        newTargetOffset = 0;
    } else if (newTargetOffset > scrollView.contentSize.height) {
        newTargetOffset = scrollView.contentSize.height;
    }
    
    targetContentOffset->y = currentOffset;
    [scrollView setContentOffset:CGPointMake(0, newTargetOffset) animated:YES];
}

- (void)willReplaceViewController {
   [((FITNavigationViewController *)self.navigationController) animateNavigationBarFromColor:[UIColor colorWithHex:@"#41c0c0"] toColor:[UIColor clearColor] duration:0.2f];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor whiteColor] duration:0.4f];
}

- (void)viewWillDisappear:(BOOL)animated {
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarFromColor:[UIColor colorWithHex:@"#5a88bc"] toColor:[UIColor clearColor] duration:0.2f];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [((FITNavigationViewController *)self.navigationController) animateNavigationBarTintToColor:[UIColor whiteColor] duration:0.4f];
    
    [super viewWillDisappear:animated];
}

- (void)didSelectRightMenuIndex:(NSInteger)index {
    [self loadDatesForWeek:index];
}

- (void)loadDatesForWeek:(NSInteger)week {
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    gregorian.firstWeekday = 2;
    NSDateComponents *components = [gregorian components:NSCalendarUnitWeekOfYear fromDate:today];
    NSUInteger weekOfYear = [components weekOfYear];
    weekOfYear+=week;
    
    self.dates = [self.presenter datesInWeek:weekOfYear];
}

- (NSInteger)currentDayIndex {
    CFAbsoluteTime at = CFAbsoluteTimeGetCurrent();
    CFTimeZoneRef tz = CFTimeZoneCopySystem();
    SInt32 weekdayNumber = CFAbsoluteTimeGetDayOfWeek(at, tz);
    return weekdayNumber;
}

- (void)reloadPlanView {
    [self.collectionView reloadData];
}

@end
