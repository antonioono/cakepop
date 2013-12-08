//
//  ArticleBodyView.m
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"

#import "ArticleBodyView.h"

@interface ArticleBodyView() {
@private
    UITextView* titleTextView;
    UILabel* authorLabel;
    UITextView* bodyTextView;
}
@end

@implementation ArticleBodyView

- (id)initWithFrame:(CGRect)frame article:(Article *)article
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        _article = article;
        
        titleTextView = [[UITextView alloc] init];
        titleTextView.scrollEnabled = NO;
        titleTextView.editable = NO;
        titleTextView.font = [UIFont fontWithName:@"Helvetica" size:48];
        titleTextView.text = _article.titleText;
        titleTextView.textColor = [UIColor whiteColor];
        titleTextView.backgroundColor = [UIColor clearColor];
        [self addSubview:titleTextView];
        
        // Create author label
        authorLabel = [[UILabel alloc] init];
        authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
        authorLabel.numberOfLines = 1;
        authorLabel.alpha = 1.0;
        authorLabel.textColor = [UIColor whiteColor];
        authorLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        authorLabel.text = _article.authorName;
        [self addSubview:authorLabel];
        
        // Create body text
        bodyTextView = [[UITextView alloc] initWithFrame:frame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Arial" size:12];
        bodyTextView.text = _article.bodyText;
        bodyTextView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bodyTextView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Subview heights
    NSInteger titleLabelHeight = 300;
    NSInteger authorLabelHeight = 100;
    
    // Subview origins
    NSInteger titleHeightOrigin = 300;
    NSInteger authorHeightOrigin = 400;
    NSInteger bodyTextHeightOrigin = 500;
    
    // Subview padding
    NSInteger titleTextSidePadding = 5;
    NSInteger authorTextSidePadding = 10;
    NSInteger bodyTextSidePadding = 0;
 
    // TitleTextView frame
    titleTextView.frame = CGRectMake(titleTextSidePadding, titleHeightOrigin, self.frame.size.width - (titleTextSidePadding * 2), titleLabelHeight);
    
    // AuthorLabel frame
    authorLabel.frame = CGRectMake(authorTextSidePadding, authorHeightOrigin, self.frame.size.width - (authorTextSidePadding * 2), authorLabelHeight);
  
    // Body Text frame
    CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, bodyTextHeightOrigin, self.frame.size.width - (bodyTextSidePadding * 2), textViewSize.height);
}

@end
