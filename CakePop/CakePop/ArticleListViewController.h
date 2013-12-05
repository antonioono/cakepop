//
//  ArticleListViewController.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PublisherCollectionViewController.h"

@interface ArticleListViewController : UITableViewController

@property(nonatomic, strong) PublisherCollectionViewController* collectionViewController;

@end
