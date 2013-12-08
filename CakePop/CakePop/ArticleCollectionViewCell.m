//
//  ArticleCollectionViewCell.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleView.h"

#import "ArticleCollectionViewCell.h"

@interface ArticleCollectionViewCell() {
@private
    UITextView* titleTextView;
    UILabel* authorLabel;
    UITextView* bodyTextView;
    UIImageView* coverPhoto;
}
@end

@implementation ArticleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Create image view (used at the top)
        coverPhoto = [[UIImageView alloc] init];
        [self addSubview:coverPhoto];
        
        titleTextView = [[UITextView alloc] init];
        titleTextView.scrollEnabled = NO;
        titleTextView.editable = NO;
        titleTextView.font = [UIFont fontWithName:@"Helvetica" size:48];
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
        [self addSubview:authorLabel];
        
        // Create body text
        bodyTextView = [[UITextView alloc] initWithFrame:frame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Arial" size:12];
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
    
    titleTextView.text = _article.titleText;
    authorLabel.text = _article.authorName;
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
 
    // Coverphoto frame
    coverPhoto.frame = CGRectMake(0,0, self.frame.size.width, coverPhotoHeight);
    
    // TitleTextView frame
    titleTextView.frame = CGRectMake(titleTextSidePadding, titleHeightOrigin, self.frame.size.width - (titleTextSidePadding * 2), titleLabelHeight);
    
    // AuthorLabel frame
    authorLabel.frame = CGRectMake(authorTextSidePadding, authorHeightOrigin, self.frame.size.width - (authorTextSidePadding * 2), authorLabelHeight);
    
    // Body Text frame
    CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, bodyTextHeightOrigin, self.frame.size.width - (bodyTextSidePadding * 2), textViewSize.height);
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
