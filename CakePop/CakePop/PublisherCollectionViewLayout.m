//
//  PublisherCollectionViewLayout.m
//  CakePop
//
//  Layout for CollectionView representing all the publishers
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "PublisherCollectionViewLayout.h"

#define OVERLAP_SIZE 250

@implementation PublisherCollectionViewLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

/*
 * Move the elements a fixed amount to create overlapping of cells
 */
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray * modifiedLayoutAttributesArray = [NSMutableArray array];
    NSInteger overlap = -OVERLAP_SIZE;
    
    [array enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * layoutAttributes, NSUInteger idx, BOOL *stop) {
        CATransform3D transform = CATransform3DIdentity;
        if (layoutAttributes.indexPath.item == 0)
        {
            transform = CATransform3DTranslate(transform, 0, 0, 0);
        } else {
            transform = CATransform3DTranslate(transform, overlap * layoutAttributes.indexPath.item, 0, 0);
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
    
    NSLog(@"mainscreen width: %f", [UIScreen mainScreen].applicationFrame.size.width);
    
    NSInteger numOverlappedPixels = ([UIScreen mainScreen].applicationFrame.size.width - OVERLAP_SIZE) * (numCells - 1);
    NSInteger numFilledSpaceWithoutOverlap = ([UIScreen mainScreen].applicationFrame.size.width) * numCells + (-1 * (numCells - 1));
    
    NSLog(@"Numcells: %d | Overlap: %d | filled Space: %d | difference: %d", numCells, numOverlappedPixels, numFilledSpaceWithoutOverlap, numFilledSpaceWithoutOverlap - numOverlappedPixels);
    
    return CGSizeMake(numFilledSpaceWithoutOverlap - numOverlappedPixels, self.collectionView.frame.size.height);
}

@end