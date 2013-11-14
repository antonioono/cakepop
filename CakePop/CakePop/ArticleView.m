//
//  ArticleListCell.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"

#import "ArticleView.h"

@interface ArticleView() {
@private
    UIImageView* coverPhoto;
    UILabel* titleLabel;
   // UILabel* bodyTextView;
    UITextView* bodyTextView;
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
        titleLabel.numberOfLines = 0;
        titleLabel.alpha = 1.0;
        [self addSubview:titleLabel];
        
        // Create image view (used at the top)
        UIImage* image = [UIImage imageNamed:article.imageName];
        coverPhoto = [[UIImageView alloc] initWithImage:image];
        [self addSubview:coverPhoto];

        /*
        // Create body text
        bodyTextView = [[UILabel alloc] initWithFrame:frame];
        bodyTextView.lineBreakMode = NSLineBreakByWordWrapping;
        bodyTextView.numberOfLines = 0;
         */
        
        bodyTextView = [[UITextView alloc] initWithFrame:frame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Helvetica" size:12];
        bodyTextView.text = _article.bodyText;
        
        [self addSubview:bodyTextView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    NSInteger coverPhotoHeight = 100;
    NSInteger titleTextSidePadding = 3;
    NSInteger bodyTextSidePadding = 12;
    
    coverPhoto.frame = CGRectMake(0,0, self.frame.size.width, coverPhotoHeight);
    
    titleLabel.frame = CGRectMake(titleTextSidePadding, 70, self.frame.size.width - titleTextSidePadding, 100);
    titleLabel.font = [UIFont fontWithName:@"Arial Bold" size:20];
    titleLabel.text = _article.titleText;
    
    CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, 140, self.frame.size.width - (bodyTextSidePadding * 2), textViewSize.height);
}

@end
