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
        _articleView.delegate = self;
        self.view = _articleView;
    }
    return self;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)backPressed
{
    NSLog(@"In back pressed of ArticleViewController!!");
    
    [self dismissViewControllerAnimated:NO completion:nil];
    
    [_parentCollectionViewController transitionBack];
    _parentCollectionViewController = nil;
}

@end
