//
//  ArticleCollectionViewCell.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleView.h"
#import "ArticleBodyView.h"

#import "ArticleCollectionViewCell.h"

@interface ArticleCollectionViewCell() {
@private
    UIImageView* coverPhoto;
    UITextView* bodyTextView;
}
@end

@implementation ArticleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _article = nil;
        
        self.backgroundColor = [UIColor whiteColor];
        // Create image view (used at the top)
        coverPhoto = [[UIImageView alloc] init];
        [self addSubview:coverPhoto];
    
        _titleTextView = [[UITextView alloc] init];
        _titleTextView.scrollEnabled = NO;
        _titleTextView.editable = NO;
        _titleTextView.userInteractionEnabled = NO;
        _titleTextView.font = [UIFont fontWithName:@"Helvetica" size:48];
        _titleTextView.text = _article.titleText;
        _titleTextView.textColor = [UIColor whiteColor];
        _titleTextView.backgroundColor = [UIColor clearColor];
        [self addSubview:_titleTextView];
        
        // Create author label
        _authorLabel = [[UILabel alloc] init];
        _authorLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _authorLabel.numberOfLines = 1;
        _authorLabel.alpha = 1.0;
        _authorLabel.textColor = [UIColor whiteColor];
        _authorLabel.font = [UIFont fontWithName:@"Helvetica" size:25];
        _authorLabel.text = _article.authorName;
        [self addSubview:_authorLabel];
        
        // Back button image
        UIImage* backButtonImage = [UIImage imageNamed:@"backButton.png"];
        _backButton = [[UIImageView alloc]initWithImage:backButtonImage];
        _backButton.hidden = YES;
        [self addSubview:_backButton];
        
        // Create body text
        bodyTextView = [[UITextView alloc] init];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Arial" size:12];
        bodyTextView.text = _article.bodyText;
        bodyTextView.backgroundColor = [UIColor whiteColor];
        [self addSubview:bodyTextView];
    }
    return self;
}

- (void)setArticle:(Article *)article
{
    _article = article;
    
    UIImage* image = [UIImage imageNamed:_article.imageName];
    [coverPhoto setImage:image];
    
    _titleTextView.text = _article.titleText;
    _authorLabel.text = _article.authorName;
    bodyTextView.text = _article.bodyText;
    
    [self setNeedsDisplay];
}

- (void)setNumber:(NSInteger)number
{
    _cellNumber = number;
}

- (void)layoutSubviews {
    [super layoutSubviews];
        
    // Subview heights
    NSInteger coverPhotoHeight = 500;
    
    // Coverphoto frame
    coverPhoto.frame = CGRectMake(0,0, self.frame.size.width, coverPhotoHeight);
    
    // Subview heights
    NSInteger titleLabelHeight = 300;
    NSInteger authorLabelHeight = 100;
    NSInteger backButtonWidth = 50;
    NSInteger backButtonHeight = 50;
    
    // Subview origins
    NSInteger titleHeightOrigin = 20;
    NSInteger authorHeightOrigin = 120;
    NSInteger bodyTextHeightOrigin = 520;
    NSInteger backButtonHeightOrigin = 20;
    
    // Subview padding
    NSInteger titleTextSidePadding = 5;
    NSInteger authorTextSidePadding = 10;
    NSInteger bodyTextSidePadding = 0;
    NSInteger backButtonWidthOrigin = -60;
    
    // TitleTextView frame
    _titleTextView.frame = CGRectMake(titleTextSidePadding, titleHeightOrigin, self.frame.size.width - (titleTextSidePadding * 2), titleLabelHeight);
    
    // AuthorLabel frame
    _authorLabel.frame = CGRectMake(authorTextSidePadding, authorHeightOrigin, self.frame.size.width - (authorTextSidePadding * 2), authorLabelHeight);
    
    // Body Text frame
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, bodyTextHeightOrigin, self.frame.size.width - (bodyTextSidePadding * 2), self.frame.size.height + 50 - bodyTextHeightOrigin);
    
    // Back Button frame
    _backButton.frame = CGRectMake(backButtonWidthOrigin, backButtonHeightOrigin, backButtonWidth, backButtonHeight);
}

- (void)prepareForReuse {
    [super prepareForReuse];
    [self setNeedsDisplay];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end