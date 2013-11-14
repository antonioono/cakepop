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
        
        //_article = article;
        _articleView = [[ArticleView alloc]initWithFrame:[UIScreen mainScreen].applicationFrame article:article];
        
        NSLog(@"application frame width: %f", [UIScreen mainScreen].applicationFrame.size.width);
        
        // This is kinda hacky
        CGFloat heightOfSubviewsBesidesBodyText = 180;
        UIView *bodyTextView = _articleView.subviews[2];
        
        NSLog(@"height of bodyText: %f", bodyTextView.frame.size.height);
        
        CGFloat totalHeight = heightOfSubviewsBesidesBodyText + bodyTextView.frame.size.height;
        
        _articleView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, totalHeight);

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
