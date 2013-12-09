//
//  ArticleCollectionViewLayout.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleCollectionViewLayout.h"

#define ADJUSTMENT 33.33

@implementation ArticleCollectionViewLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.headerReferenceSize = CGSizeMake(0, 100);

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

/*
 * Move the elements a fixed amount to create overlapping of cells
 */
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"Width of screen: %f", [UIScreen mainScreen].bounds.size.width);
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray * modifiedLayoutAttributesArray = [NSMutableArray array];
    CGFloat overlap = [UIScreen mainScreen].bounds.size.width + ADJUSTMENT;
    
    [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * layoutAttributes, NSUInteger idx, BOOL *stop) {
        CATransform3D transform = CATransform3DIdentity;
        if (layoutAttributes.indexPath.item == 0)
        {
            transform = CATransform3DTranslate(transform, 0, 0, 0);
        } else {
            transform = CATransform3DTranslate(transform, -(overlap * layoutAttributes.indexPath.item), 200 * layoutAttributes.indexPath.item, 0);
        }
        layoutAttributes.transform3D = transform;
        
        // right card is always on top
        layoutAttributes.zIndex = layoutAttributes.indexPath.item;
        
        [modifiedLayoutAttributesArray addObject:layoutAttributes];
    }];
    
    return modifiedLayoutAttributesArray;
}

/*
 * Kind of weird bug here caused by this or the method above it, but with 10 publishers this looks good. (Will explore if I have time)
 */
- (CGSize)collectionViewContentSize
{
    NSInteger numCells = [self.collectionView numberOfItemsInSection:0];
    NSInteger overlap = [UIScreen mainScreen].bounds.size.width + self.minimumInteritemSpacing;
    
    NSInteger numOverlappedPixels = ([UIScreen mainScreen].applicationFrame.size.width - overlap) * (numCells - 1);
    NSInteger numFilledSpaceWithoutOverlap = ([UIScreen mainScreen].applicationFrame.size.width) * numCells + (-1 * (numCells - 1));
    
    NSLog(@"Numcells: %d | Overlap: %d | filled Space: %d | difference: %d", numCells, numOverlappedPixels, numFilledSpaceWithoutOverlap, numFilledSpaceWithoutOverlap - numOverlappedPixels);
    
    return CGSizeMake(self.collectionView.frame.size.width, numFilledSpaceWithoutOverlap - numOverlappedPixels);
}

@end