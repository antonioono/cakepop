//
//  ArticleViewController.m
//  CakePop
//
//  Created by Christina Yoon on 11/8/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"
#import "ArticleView.h"

#import "ArticleViewController.h"


@interface ArticleViewController ()
{
@private
    ArticleView* _articleView;
}

@end


@implementation ArticleViewController

- (id)initWithArticle:(Article *)article
{
    self = [super init];
    if (self) {
        _articleView = [[ArticleView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame article:article];
        self.view = _articleView;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    
    NSLog(@"View did load for %@", _article.titleText);
}

@end
