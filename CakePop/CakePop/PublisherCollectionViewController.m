//
//  PublisherCollectionViewController.m
//  CakePop
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "PublisherCollectionViewCell.h"
#import "PublisherCollectionViewLayout.h"

#import "PublisherCollectionViewController.h"

@interface PublisherCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray * imagesArray;
@property (nonatomic, strong) NSMutableArray * imageNamesArray;

@end

@implementation PublisherCollectionViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initImages];
    
    self.collectionView.frame = CGRectMake(0,0, 1000, [UIScreen mainScreen].applicationFrame.size.height);
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

    [cell setNumber:3];
    cell.imageName = self.imageNamesArray[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // implement your cell selected logic here
    UIImageView * selectedImageView = self.imagesArray[indexPath.item];
    NSLog(@"selected image: %@", selectedImageView);
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
    
    UIImageView * image1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    UIImageView * image2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"2"]];
    UIImageView * image3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    UIImageView * image4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"4"]];
    UIImageView * image5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"5"]];
    UIImageView * image6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"6"]];
    UIImageView * image7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"7"]];

    
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
    self.imageNamesArray[3] = @"6";
    [self.imagesArray addObject:image7];
    self.imageNamesArray[4] = @"7";

}

@end
