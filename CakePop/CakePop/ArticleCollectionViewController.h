//
//  ArticleCollectionViewController.h
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

@class Publisher;

#import "ArticleCollectionViewHeader.h"
#import "PublisherCollectionViewController.h"
#import <UIKit/UIKit.h>

@interface ArticleCollectionViewController : UICollectionViewController <ArticleCollectionViewHeaderDelegate>

@property(nonatomic, strong) PublisherCollectionViewController* parentCollectionViewController;
@property(nonatomic, strong) Publisher* publisher;

- (void)transitionBack;

@end
