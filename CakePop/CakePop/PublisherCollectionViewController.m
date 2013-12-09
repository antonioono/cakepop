//
//  PublisherCollectionViewController.m
//  CakePop
//
//  Controller for collectionview representing all the publishers
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"
#import "ArticleCollectionViewController.h"
#import "ArticleCollectionViewLayout.h"
#import "ArticleListViewController.h"
#import "Publisher.h"
#import "PublisherCollectionViewCell.h"
#import "PublisherCollectionViewLayout.h"
#import "SettingsView.h"

#import "PublisherCollectionViewController.h"

@interface PublisherCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, assign) NSInteger currentSelectedCellNumber;
@property (nonatomic, assign) CGFloat originalXPosition;
@property (nonatomic, strong) NSMutableArray* publisherArray;
@property (nonatomic, strong) NSArray* visibleCells;
@property (nonatomic, strong) SettingsView* settingsView;
@property (nonatomic, assign) BOOL settingsPageShowing;

@end

@implementation PublisherCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initPublisherAndArticles];
    
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    [swipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [swipeUp setDirection:UISwipeGestureRecognizerDirectionUp];
    // Adding the swipe gesture on image view
    [self.view addGestureRecognizer:swipeDown];
    [self.view addGestureRecognizer:swipeUp];
    
    CGRect settingsFrame = CGRectMake(0, -[UIScreen mainScreen].applicationFrame.size.height, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
    self.settingsView = [[SettingsView alloc]initWithFrame:settingsFrame];
    [self.view addSubview:self.settingsView];
    
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

#pragma mark - Gesture Recognizer
- (void)handleSwipe:(UISwipeGestureRecognizer *)swipe {
    
    if (swipe.direction == UISwipeGestureRecognizerDirectionDown && _settingsPageShowing == NO) {
        NSLog(@"Down Swipe");
        _settingsPageShowing = YES;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGRect transitionToFrame = CGRectMake(0, 15, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
        self.settingsView.frame = transitionToFrame;
        [UIView commitAnimations];
    } else if (swipe.direction == UISwipeGestureRecognizerDirectionUp && _settingsPageShowing == YES) {
        NSLog(@"Up Swipe");
        _settingsPageShowing = NO;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:1.0];
        [UIView setAnimationDelay:0.0];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        CGRect transitionToFrame = CGRectMake(0, -[UIScreen mainScreen].applicationFrame.size.height, [UIScreen mainScreen].applicationFrame.size.width, [UIScreen mainScreen].applicationFrame.size.height);
        self.settingsView.frame = transitionToFrame;
        [UIView commitAnimations];

    }
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
                         ArticleCollectionViewLayout * collectionViewLayout = [[ArticleCollectionViewLayout alloc] init];

                         ArticleCollectionViewController* articleCollectionViewController = [[ArticleCollectionViewController alloc] initWithCollectionViewLayout:collectionViewLayout];
                         articleCollectionViewController.parentCollectionViewController = self;
                         
                         articleCollectionViewController.publisher = _publisherArray[_currentSelectedCellNumber];
                         [self presentViewController:articleCollectionViewController animated:YES completion:nil];
                     }];
}

- (void)transitionBack {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5];
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

/*
 * Initializes one sample article
 */
- (Article *)createOneSampleArticle {
    NSString* articleTitleText = @"Article Title Here!";
    NSString* articleBodyText = @"Article one body text: Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! Repeated words are fun! END OF TEXT";
    NSString* articleImageName = @"Dismemberment Plan.png";
    NSString* articleAuthorName = @"Author name";
    NSString* articleURI = @"www.article.com";
    
    Article* article = [[Article alloc] initWithTitleText:articleTitleText bodyText:articleBodyText imageName:articleImageName authorName:articleAuthorName uri:articleURI];
    
    return article;
}


/*
 * Initializes Publishers and articles
 *
 * Works best if you have 10 publishers + 10 articles for each publisher (there are subtle layout bugs otherwise that I don't have time to dive into)
 */
- (void) initPublisherAndArticles {
    self.publisherArray = [NSMutableArray array];
    
    //Create 10 same publishers
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
    
    //Add the same article 10 times for ea publisher
    for (int i = 0; i < [self.publisherArray count]; i++)
    {
        Publisher* currentPublisher = self.publisherArray[i];

        NSMutableArray* mutableArticleArray = [[NSMutableArray alloc] init];
        for(int i = 0; i < 10; i++)
        {
            Article* article = [self createOneSampleArticle];
            NSLog(@"%@", article.bodyText);
            [mutableArticleArray addObject:[self createOneSampleArticle]];
        }
        NSArray* articleArray = [NSArray arrayWithArray:mutableArticleArray];
        currentPublisher.articles = articleArray;
        //currentPublisher.articles = [[NSMutableArray alloc] initWithArray:articleArray copyItems:YES];

    }
}

@end
