//
//  PublisherCollectionViewController.m
//  CakePop
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleListViewController.h"
#import "PublisherCollectionViewCell.h"
#import "PublisherCollectionViewLayout.h"

#import "PublisherCollectionViewController.h"

@interface PublisherCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray* imagesArray;
@property (nonatomic, strong) NSMutableArray* imageNamesArray;

@property (nonatomic, assign) NSInteger currentSelectedCellNumber;
@property (nonatomic, assign) CGFloat originalXPosition;

@end

@implementation PublisherCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImages];
    
    self.collectionView.frame = CGRectMake(0,0, 2000, [UIScreen mainScreen].applicationFrame.size.height);
    [self.collectionView registerClass:[PublisherCollectionViewCell class] forCellWithReuseIdentifier:@"ItemIdentifier"];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
}

/*
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, -500);
}
 */

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PublisherCollectionViewCell *cell = (PublisherCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ItemIdentifier" forIndexPath:indexPath];

    [cell setNumber:indexPath.item];
    cell.imageName = self.imageNamesArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"selected image: %d", indexPath.item);
    _currentSelectedCellNumber = indexPath.item;

    NSArray* visibleCells = self.collectionView.visibleCells;
    _visibleCells = visibleCells;
    [UIView animateWithDuration:1.0
                          delay:0.0
                        options: UIViewAnimationCurveEaseOut
                     animations:^{
                         for (int i = 0; i < [visibleCells count]; i++) {
                             PublisherCollectionViewCell* currentCell = visibleCells[i];
                             if (currentCell.cellNumber < _currentSelectedCellNumber) {
                                 CGRect frame = currentCell.frame;
                                 frame.origin.x = frame.origin.x - 300;
                                 currentCell.frame = frame;
                             }
                             
                             if (currentCell.cellNumber == _currentSelectedCellNumber) {
                                 _originalXPosition = currentCell.frame.origin.x;
                                 CGRect frame = currentCell.frame;
                                 frame.origin.x = self.collectionView.frame.origin.x + self.collectionView.contentOffset.x;
                                 currentCell.frame = frame;
                             }
                             
                             if (currentCell.cellNumber > _currentSelectedCellNumber) {
                                 CGRect frame = currentCell.frame;
                                 frame.origin.x = frame.origin.x + 300;
                                 currentCell.frame = frame;
                             }
                         }
                     }
                     completion:^(BOOL finished){
                         ArticleListViewController* articleListViewController = [[ArticleListViewController alloc] init];
                         articleListViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                         articleListViewController.collectionViewController = self;
                         [self.navigationController pushViewController:articleListViewController animated:YES];
                     }];
}

- (void)transitionBack {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    for (int i = 0; i < [_visibleCells count]; i++) {
        PublisherCollectionViewCell* currentCell = _visibleCells[i];
        if (currentCell.cellNumber < _currentSelectedCellNumber) {
            CGRect frame = currentCell.frame;
            frame.origin.x = frame.origin.x + 300;
            currentCell.frame = frame;
        }
        
        if (currentCell.cellNumber == _currentSelectedCellNumber) {
            CGRect frame = currentCell.frame;
            frame.origin.x = _originalXPosition;
            currentCell.frame = frame;
        }
        
        if (currentCell.cellNumber > _currentSelectedCellNumber) {
            CGRect frame = currentCell.frame;
            frame.origin.x = frame.origin.x - 300;
            currentCell.frame = frame;
        }
    }

    /*
    UICollectionViewCell* firstCell = self.visibleCells[0];
    CGRect frame = firstCell.frame;
    frame.origin.x = frame.origin.x - 300;
    firstCell.frame = frame;
    */
    
    [UIView commitAnimations];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"scrollViewDidEndDecelerating...");
    [self printCurrentCard];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate){
        NSLog(@"scrollViewDidEndDragging...");
        [self printCurrentCard];
    }
}

- (void)printCurrentCard{
    NSArray * visibleCards = self.collectionView.visibleCells;
    [visibleCards enumerateObjectsUsingBlock:^(PublisherCollectionViewCell * visibleCell, NSUInteger idx, BOOL *stop) {
        NSLog(@"visible cell: %@", visibleCell.imageName);
    }];
}


- (void) initImages {
    self.imagesArray = [NSMutableArray array];
    self.imageNamesArray = [NSMutableArray array];
    
    UIImageView * image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dismemberment Plan.png"]];
    UIImageView * image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]];
    UIImageView * image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    UIImageView * image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4"]];
    UIImageView * image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5"]];
    UIImageView * image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6"]];
    UIImageView * image7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7"]];
    UIImageView * image8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"8"]];
    UIImageView * image9 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"9"]];
    UIImageView * image10 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"10"]];
    
    [self.imagesArray addObject:image1];
    self.imageNamesArray[0] = @"1";
    [self.imagesArray addObject:image2];
    self.imageNamesArray[1] = @"2";
    [self.imagesArray addObject:image3];
    self.imageNamesArray[2] = @"3";
    [self.imagesArray addObject:image4];
    self.imageNamesArray[3] = @"4";
    [self.imagesArray addObject:image5];
    self.imageNamesArray[4] = @"5";
    [self.imagesArray addObject:image6];
    self.imageNamesArray[5] = @"6";
    [self.imagesArray addObject:image7];
    self.imageNamesArray[6] = @"7";
    [self.imagesArray addObject:image8];
    self.imageNamesArray[7] = @"8";
    [self.imagesArray addObject:image9];
    self.imageNamesArray[8] = @"9";
    [self.imagesArray addObject:image10];
    self.imageNamesArray[9] = @"10";

}

@end
