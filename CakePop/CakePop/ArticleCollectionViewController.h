//
//  ArticleCollectionViewController.h
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

@class Publisher;

#import <UIKit/UIKit.h>

@interface ArticleCollectionViewController : UICollectionViewController

@property(nonatomic, strong) Publisher* publisher;

- (void)transitionBack;

@end
