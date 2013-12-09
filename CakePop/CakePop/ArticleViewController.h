//
//  ArticleViewController.h
//  CakePop
//
//  Created by Christina Yoon on 11/8/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

@class Article;

#import <UIKit/UIKit.h>
#import "ArticleCollectionViewController.h"
#import "ArticleView.h"

@interface ArticleViewController : UIViewController <ArticleViewDelegate>

@property(nonatomic, strong) Article* article;
@property(nonatomic, strong) ArticleCollectionViewController* parentCollectionViewController;

- (id)initWithArticle:(Article *)article;

@end
