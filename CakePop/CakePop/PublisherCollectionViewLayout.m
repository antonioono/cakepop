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

@implementation PublisherCollectionViewLayout

-(id)init
{
    if (!(self = [super init])) return nil;
    
    self.itemSize = CGSizeMake(100.0f, 153.0f);
    self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.itemSize = CGSizeMake(100.0f, 153.0f);
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

- (void)prepareLayout {
    self.superView = self.collectionView.superview;
}

/*
 * Move the elements a fixed amount to create overlapping of cells
 *
 * Bug: Scrolling to the very last few cells is weird, followed by lots of black (aka avoid scrolling to end)
 */
/*
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    
    NSInteger overlapBetweenCells = -250;
    
    for (int i = 1; i < [array count]; i++) {
 
        UICollectionViewLayoutAttributes* currentLayoutAttributes = array[i];
        UICollectionViewLayoutAttributes* prevLayoutAttributes = array[i-1];
        
        NSInteger origin = CGRectGetMaxX(prevLayoutAttributes.frame);
        CGRect frame = currentLayoutAttributes.frame;
        frame.origin.x = origin + overlapBetweenCells;
        currentLayoutAttributes.frame = frame;
        currentLayoutAttributes.zIndex = currentLayoutAttributes.indexPath.item;
 
        
    }
    
    return array;
}
 */


/*
 * Move the elements a fixed amount to create overlapping of cells
 *
 * Bug: Scrolling to the very last few cells is weird, followed by lots of black (aka avoid scrolling to end)
 */
- (NSArray*)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * array = [super layoutAttributesForElementsInRect:rect];
    NSMutableArray * modifiedLayoutAttributesArray = [NSMutableArray array];
    NSInteger overlap = -250;
    
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
// http://stackoverflow.com/questions/13749401/stopping-the-scroll-in-a-uicollectionview

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    
    CGFloat offsetAdjustment = CGFLOAT_MAX;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 1.4f);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x,
                                   0.0f, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    
    NSArray *array = [super layoutAttributesForElementsInRect:targetRect];
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat distanceFromCenter = layoutAttributes.center.x - horizontalCenter;
        if (ABS(distanceFromCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = distanceFromCenter;
        }
    }
    
    return CGPointMake(
                       proposedContentOffset.x + offsetAdjustment,
                       proposedContentOffset.y);
}*/
/*
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}
 */

@end