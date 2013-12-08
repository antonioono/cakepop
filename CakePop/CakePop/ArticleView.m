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
}
@end

@implementation ArticleView

- (id)initWithFrame:(CGRect)frame article:(Article *)article
{
    self = [super initWithFrame:frame];
    if (self) {
        _article = article;
    
        self.backgroundColor = [UIColor whiteColor];    
        // Create image view (used at the top)
        UIImage* image = [UIImage imageNamed:article.imageName];
        coverPhoto = [[UIImageView alloc] initWithImage:image];
        [self addSubview:coverPhoto];
        
        // TODO: This is kinda hacky, it works but will fix if I have time, basically this creates the textview that the bodyView uses to calculate the size, thus if anything is changed there this needs to be updated as well
        CGFloat heightOfSubviewsBesidesBodyText = 500;
        UITextView* bodyTextView = [[UITextView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Arial" size:12];
        bodyTextView.text = article.bodyText;
        CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
        
        bodyView = [[ArticleBodyView alloc] initWithFrame:self.frame article:article];
        bodyView.pagingEnabled = NO;
        bodyView.contentSize = CGSizeMake([UIScreen mainScreen].applicationFrame.size.width, heightOfSubviewsBesidesBodyText + textViewSize.height);
        [self addSubview:bodyView];
        [self bringSubviewToFront:bodyView];
    }
    return self;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    // Subview heights
    NSInteger coverPhotoHeight = 500;

    // Coverphoto frame
    coverPhoto.frame = CGRectMake(0,0, self.frame.size.width, coverPhotoHeight);
}

@end
