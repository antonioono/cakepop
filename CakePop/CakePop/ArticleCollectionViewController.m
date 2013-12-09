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
@property (nonatomic, assign) CGFloat originalYPosition;
@property (nonatomic, strong) NSArray* articleArray;
@property (nonatomic, strong) NSArray* visibleCells;

@end

@implementation ArticleCollectionViewController

- (void)setPublisher:(Publisher *)publisher
{
    _publisher = publisher;
    self.articleArray = _publisher.articles;

    [self.view setNeedsDisplay];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    return [self.articleArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCollectionViewCell *cell = (ArticleCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ArticleCell" forIndexPath:indexPath];

    Article* currentArticle = self.articleArray[indexPath.item];
    
    [cell setNumber:indexPath.item];
    [cell setArticle:currentArticle];
    
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
                                 _originalYPosition = currentCell.frame.origin.y;
                                 CGRect frame = currentCell.frame;
                                 frame.origin.y = self.collectionView.frame.origin.y + self.collectionView.contentOffset.y;
                                 currentCell.frame = frame;
                                 
                                 CGRect titleFrame = currentCell.titleTextView.frame;
                                 CGRect newTitleFrame = CGRectMake(titleFrame.origin.x, titleFrame.origin.y + 300, titleFrame.size.width, titleFrame.size.height);
                                 currentCell.titleTextView.frame = newTitleFrame;
                                 
                                 CGRect authorFrame = currentCell.authorLabel.frame;
                                 CGRect newAuthorFrame = CGRectMake(authorFrame.origin.x, authorFrame.origin.y + 300, authorFrame.size.width, authorFrame.size.height);
                                 currentCell.authorLabel.frame = newAuthorFrame;
                                 
                                 currentCell.backButton.hidden = NO;
                                 CGRect backButtonFrame = currentCell.backButton.frame;
                                 CGRect newBackButtonFrame = CGRectMake(backButtonFrame.origin.x + 65, backButtonFrame.origin.y, backButtonFrame.size.width, backButtonFrame.size.height);
                                 currentCell.backButton.frame = newBackButtonFrame;
                             }
                             
                             if (currentCell.cellNumber > _currentSelectedCellNumber) {
                                 CGRect frame = currentCell.frame;
                                 frame.origin.y = frame.origin.y + 500;
                                 currentCell.frame = frame;
                             }
                         }
                     }

                     completion:^(BOOL finished){
                         Article* article = _articleArray[_currentSelectedCellNumber];
                         
                         ArticleViewController* articleViewController = [[ArticleViewController alloc] initWithArticle:article];
                         articleViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                         articleViewController.parentCollectionViewController = self;
                         
                         [self presentViewController:articleViewController animated:NO completion:nil];
                         //[self.navigationController pushViewController:articleListViewController animated:YES];
                         
                     }];
}

- (void)backPressed {    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [_parentCollectionViewController transitionBack];
    _parentCollectionViewController = nil;
}

- (void)transitionBack {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelay:0.0];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    for (int i = 0; i < [_visibleCells count]; i++) {
        ArticleCollectionViewCell* currentCell = _visibleCells[i];
        if (currentCell.cellNumber < _currentSelectedCellNumber) {
            CGRect frame = currentCell.frame;
            frame.origin.y = frame.origin.y + 500;
            currentCell.frame = frame;
        }
        
        if (currentCell.cellNumber == _currentSelectedCellNumber) {
            CGRect frame = currentCell.frame;
            frame.origin.y = _originalYPosition;
            currentCell.frame = frame;
            
            CGRect titleFrame = currentCell.titleTextView.frame;
            CGRect newTitleFrame = CGRectMake(titleFrame.origin.x, titleFrame.origin.y - 300, titleFrame.size.width, titleFrame.size.height);
            currentCell.titleTextView.frame = newTitleFrame;
            
            CGRect authorFrame = currentCell.authorLabel.frame;
            CGRect newAuthorFrame = CGRectMake(authorFrame.origin.x, authorFrame.origin.y - 300, authorFrame.size.width, authorFrame.size.height);
            currentCell.authorLabel.frame = newAuthorFrame;
            
            currentCell.backButton.hidden = NO;
            CGRect backButtonFrame = currentCell.backButton.frame;
            CGRect newBackButtonFrame = CGRectMake(backButtonFrame.origin.x - 65, backButtonFrame.origin.y, backButtonFrame.size.width, backButtonFrame.size.height);
            currentCell.backButton.frame = newBackButtonFrame;
        }
        
        if (currentCell.cellNumber > _currentSelectedCellNumber) {
            CGRect frame = currentCell.frame;
            frame.origin.y = frame.origin.y - 500;
            currentCell.frame = frame;
        }
    }
    
    [UIView commitAnimations];
}

@end
