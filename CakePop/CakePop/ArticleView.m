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
    UITextView* bodyTextView;
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
        
        // Create body text
        bodyTextView = [[UITextView alloc] initWithFrame:frame];
        bodyTextView.editable = NO;
        [self addSubview:bodyTextView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    NSInteger coverPhotoHeight = 100;
    NSInteger titleTextSidePadding = 3;
    NSInteger bodyTextSidePadding = 8;
    
    coverPhoto.frame = CGRectMake(0,0, self.frame.size.width, coverPhotoHeight);
    
    titleLabel.frame = CGRectMake(titleTextSidePadding, 70, self.frame.size.width - titleTextSidePadding, 100);
    titleLabel.font = [UIFont fontWithName:@"Arial Bold" size:20];
    titleLabel.text = _article.titleText;
    
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, 140, self.frame.size.width - bodyTextSidePadding, self.frame.size.height - 210);
    bodyTextView.font = [UIFont fontWithName:@"Helvetica" size:15];
    bodyTextView.text = _article.bodyText;
}

@end
