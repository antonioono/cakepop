//
//  PublisherCollectionViewController.m
//  CakePop
//
//  Controller for collectionview representing all the publishers
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleCollectionViewController.h"
#import "ArticleCollectionViewLayout.h"
#import "ArticleListViewController.h"
#import "Publisher.h"
#import "PublisherCollectionViewCell.h"
#import "PublisherCollectionViewLayout.h"

#import "PublisherCollectionViewController.h"

@interface PublisherCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger currentSelectedCellNumber;
@property (nonatomic, assign) CGFloat originalXPosition;
@property (nonatomic, strong) NSMutableArray* publisherArray;
@property (nonatomic, strong) NSArray* visibleCells;

@end

@implementation PublisherCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImages];
    
    self.navigationController.navigationBarHidden = NO;
    self.collectionView.frame = CGRectMake(0, 0, 2000, [UIScreen mainScreen].applicationFrame.size.height);
    [self.collectionView registerClass:[PublisherCollectionViewCell class] forCellWithReuseIdentifier:@"PublisherCell"];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor clearColor];
}

#pragma mark - Status bar stuff

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView {
    return 1;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height + 20);
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.publisherArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    PublisherCollectionViewCell *cell = (PublisherCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PublisherCell" forIndexPath:indexPath];
    
    Publisher* currentPublisher = self.publisherArray[indexPath.item];
    
    [cell setNumber:indexPath.item];
    [cell setImageUnread:currentPublisher.imageNameUnread imageNameRead:currentPublisher.imageNameRead isRead:currentPublisher.isRead];

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
                         /*
                         ArticleListViewController* articleListViewController = [[ArticleListViewController alloc] init];
                         articleListViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                         articleListViewController.collectionViewController = self;
                         
                         [self.publisherArray[indexPath.item] setIsRead:YES];
                         [self presentViewController:articleListViewController animated:YES completion:nil];
                          */
                         //[self.navigationController pushViewController:articleListViewController animated:YES];
                         
                         ArticleCollectionViewLayout * collectionViewLayout = [[ArticleCollectionViewLayout alloc] init];

                         ArticleCollectionViewController* articleCollectionViewController = [[ArticleCollectionViewController alloc] initWithCollectionViewLayout:collectionViewLayout];
                         articleCollectionViewController.publisher = _publisherArray[_currentSelectedCellNumber];
                         [self presentViewController:articleCollectionViewController animated:YES completion:nil];
                     }];
}

- (void)transitionBack {
    self.navigationController.navigationBarHidden = YES;
    
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
    
    [UIView commitAnimations];
}
/*
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
        NSLog(@"visible cell: %@", visibleCell.imageNameUnread);
    }];
}
 */


- (void) initImages {
    self.publisherArray = [NSMutableArray array];
    
    Publisher* publisher1 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher2 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher3 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher4 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher5 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher6 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher7 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher8 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher9 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];
    Publisher* publisher10 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png" headerLogoImage:@"logo.png"];

    [self.publisherArray addObject:publisher1];
    [self.publisherArray addObject:publisher2];
    [self.publisherArray addObject:publisher3];
    [self.publisherArray addObject:publisher4];
    [self.publisherArray addObject:publisher5];
    [self.publisherArray addObject:publisher6];
    [self.publisherArray addObject:publisher7];
    [self.publisherArray addObject:publisher8];
    [self.publisherArray addObject:publisher9];
    [self.publisherArray addObject:publisher10];
}

@end
