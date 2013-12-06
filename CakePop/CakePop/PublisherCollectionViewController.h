//
//  PublisherCollectionViewController.h
//  CakePop
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PublisherCollectionViewController : UICollectionViewController

@property (nonatomic, strong) NSArray* visibleCells;

- (void)transitionBack;

@end
