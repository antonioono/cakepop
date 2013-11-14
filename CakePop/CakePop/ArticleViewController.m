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
        
        NSLog(@"application frame width: %f", [UIScreen mainScreen].applicationFrame.size.width);
        
        CGFloat heightOfSubviewsBesidesBodyText = 170;

        // TODO: This is kinda hacky, it works but will fix if I have time
        UITextView* bodyTextView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Helvetica" size:12];
        bodyTextView.text = article.bodyText;
        CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
        
        CGFloat totalHeight = heightOfSubviewsBesidesBodyText + textViewSize.height;
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
