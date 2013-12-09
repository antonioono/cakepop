//
//  ArticleCollectionViewController.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"
#import "ArticleCollectionViewCell.h"
#import "ArticleCollectionViewHeader.h"
#import "ArticleViewController.h"

#import "Publisher.h"

#import "ArticleCollectionViewController.h"

#define HEADER_SIZE 70

@interface ArticleCollectionViewController ()

@property (nonatomic, assign) NSInteger currentSelectedCellNumber;
@property (nonatomic, assign) CGFloat originalXPosition;
@property (nonatomic, strong) NSMutableArray* articleArray;
@property (nonatomic, strong) NSMutableArray* publisherArray;
@property (nonatomic, strong) NSArray* visibleCells;

@end

@implementation ArticleCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImages];
    
    [self.collectionView registerClass:[ArticleCollectionViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
    withReuseIdentifier:@"HeaderView"];
    
    self.view.backgroundColor = [UIColor blackColor];
    self.collectionView.frame = CGRectMake(0, 0, 3500, 5 *[UIScreen mainScreen].applicationFrame.size.height);
    [self.collectionView registerClass:[ArticleCollectionViewCell class] forCellWithReuseIdentifier:@"ArticleCell"];
    self.collectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.bounces = NO;
    self.collectionView.decelerationRate = UIScrollViewDecelerationRateNormal;
    self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.collectionView.backgroundColor = [UIColor clearColor];
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)cv viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    UICollectionReusableView *reusableView = nil;

    if (kind == UICollectionElementKindSectionHeader) {
        ArticleCollectionViewHeader *collectionHeader = [self.collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        collectionHeader.delegate = self;
        
        [collectionHeader setHeaderImageName:_publisher.headerLogoImage];
        
        reusableView = collectionHeader;
    }
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section;
{
    return CGSizeMake([UIScreen mainScreen].bounds.size.width, HEADER_SIZE);
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
    return CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.publisherArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCollectionViewCell *cell = (ArticleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];

    //Article* currentArticle = self.articleArray[indexPath.item];
    
    [cell setNumber:indexPath.item];
    NSString* article1TitleText = @"Article one title";
    NSString* article1BodyText = @"Article one body text: Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! END OF TEXT";
    NSString* article1ImageName = @"Dismemberment Plan.png";
    NSString* article1AuthorName = @"Author1 name";
    NSString* article1URI = @"www.article1.com";
    Article* article1 = [[Article alloc] initWithTitleText:article1TitleText bodyText:article1BodyText imageName:article1ImageName authorName:article1AuthorName uri:article1URI];
    [cell setArticle:article1];
    
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
                             ArticleCollectionViewCell* currentCell = visibleCells[i];
                             if (currentCell.cellNumber < _currentSelectedCellNumber) {
                                 CGRect frame = currentCell.frame;
                                 frame.origin.y = frame.origin.y - 500;
                                 currentCell.frame = frame;
                             }
                             
                             if (currentCell.cellNumber == _currentSelectedCellNumber) {
                                 _originalXPosition = currentCell.frame.origin.y;
                                 CGRect frame = currentCell.frame;
                                 frame.origin.y = self.collectionView.frame.origin.y + self.collectionView.contentOffset.y;
                                 currentCell.frame = frame;
                             }
                             
                             if (currentCell.cellNumber > _currentSelectedCellNumber) {
                                 CGRect frame = currentCell.frame;
                                 frame.origin.y = frame.origin.y + 500;
                                 currentCell.frame = frame;
                             }
                         }
                     }

                     completion:^(BOOL finished){
                         //Article* article = articleArray[_currentSelectedCellNumber];
                         NSString* article1TitleText = @"Article one title";
                         NSString* article1BodyText = @"Article one body text: Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! END OF TEXT";
                         NSString* article1ImageName = @"Dismemberment Plan.png";
                         NSString* article1AuthorName = @"Author1 name";
                         NSString* article1URI = @"www.article1.com";
                         Article* article1 = [[Article alloc] initWithTitleText:article1TitleText bodyText:article1BodyText imageName:article1ImageName authorName:article1AuthorName uri:article1URI];

                         ArticleViewController* articleViewController = [[ArticleViewController alloc] initWithArticle:article1];
                         articleViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                         articleViewController.parentCollectionViewController = self;
                         
                         [self.publisherArray[indexPath.item] setIsRead:YES];
                         [self presentViewController:articleViewController animated:NO completion:nil];
                         //[self.navigationController pushViewController:articleListViewController animated:YES];
                         
                     }];
}

- (void)backPressed {
    NSLog(@"In back pressed of delegate what up!");
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [_parentCollectionViewController transitionBack];
    _parentCollectionViewController = nil;
}
/*
- (void)transitionBack {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    for (int i = 0; i < [_visibleCells count]; i++) {
        ArticleCollectionViewCell* currentCell = _visibleCells[i];
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
*/

- (void) initImages {
    self.publisherArray = [NSMutableArray array];
    
    Publisher* publisher1 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher2 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher3 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher4 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher5 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher6 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher7 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher8 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher9 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    Publisher* publisher10 = [[Publisher alloc] initWithImageNameUnread:@"Dismemberment Plan.png" imageNameRead:@"Dismemberment Plan.png"];
    
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
