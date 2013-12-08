//
//  ArticleView.m
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"
#import "ArticleBodyView.h"

#import "ArticleView.h"

@interface ArticleView() {
@private
    UIImageView* coverPhoto;
    ArticleBodyView* bodyView;
    CGFloat textHeight;
}
@end

@implementation ArticleView

- (id)initWithFrame:(CGRect)frame article:(Article *)article
{
    self = [super initWithFrame:frame];
    if (self) {
        _article = article;
    
        self.backgroundColor = [UIColor whiteColor];    
        
        // Create title label
        titleLabel = [[UILabel alloc] init];
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.numberOfLines = 1;
        titleLabel.alpha = 1.0;
        [titleLabel setFont:[UIFont fontWithName:@"Arial" size:18]];
        titleLabel.text = _article.titleText;
        [self addSubview:titleLabel];
        
        // Create author label
        authorLabel = [[UILabel alloc] init];
        authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
        authorLabel.numberOfLines = 1;
        authorLabel.alpha = 1.0;
        authorLabel.font = [UIFont fontWithName:@"Arial" size:15];
        authorLabel.text = _article.authorName;
        [self addSubview:authorLabel];
        
        // Create image view (used at the top)
        UIImage* image = [UIImage imageNamed:article.imageName];
        coverPhoto = [[UIImageView alloc] initWithImage:image];
        [self addSubview:coverPhoto];
        
        CGFloat heightOfSubviewsBesidesBodyText = 450;
        // TODO: This is kinda hacky, it works but will fix if I have time
        UITextView* bodyTextView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Helvetica" size:12];
        bodyTextView.text = article.bodyText;
        CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
        
        bodyView = [[ArticleBodyView alloc] initWithFrame:self.frame article:article];
        bodyView.pagingEnabled = YES;
        bodyView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, heightOfSubviewsBesidesBodyText + textViewSize.height);
        [self addSubview:bodyView];
        [self bringSubviewToFront:bodyView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    // Subview heights
    NSInteger coverPhotoHeight = 450;
    NSInteger titleLabelHeight = 100;
    NSInteger authorLabelHeight = 100;
    
    // Subview origins
    NSInteger titleHeightOrigin = 370;
    NSInteger authorHeightOrigin = 390;
    NSInteger bodyTextHeightOrigin = 450;
    
    // Subview padding
    NSInteger titleTextSidePadding = 5;
    NSInteger authorTextSidePadding = 10;
    NSInteger bodyTextSidePadding = 12;
    
    // Coverphoto frame
    coverPhoto.frame = CGRectMake(0,0, self.frame.size.width, coverPhotoHeight);
    
    // TitleLabel frame
    titleLabel.frame = CGRectMake(titleTextSidePadding, titleHeightOrigin, self.frame.size.width - (titleTextSidePadding * 2), titleLabelHeight);
    
    // AuthorLabel frame
    authorLabel.frame = CGRectMake(authorTextSidePadding, authorHeightOrigin, self.frame.size.width - (authorTextSidePadding * 2), authorLabelHeight);
    
    bodyView.frame = self.frame;
    // Body Text frame
    /*
    CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, bodyTextHeightOrigin, self.frame.size.width - (bodyTextSidePadding * 2), textViewSize.height);
     */
}

@end
