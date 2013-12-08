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
    UILabel* titleLabel;
    UILabel* authorLabel;
    UITextView* bodyTextView;
    CGFloat textHeight;
}
@end

@implementation ArticleBodyView

- (id)initWithFrame:(CGRect)frame article:(Article *)article
{
    self = [super initWithFrame:frame];
    if (self) {
        _article = article;
        // Create body text
        bodyTextView = [[UITextView alloc] initWithFrame:frame];
        bodyTextView.scrollEnabled = NO;
        bodyTextView.editable = NO;
        bodyTextView.font = [UIFont fontWithName:@"Helvetica" size:12];
        bodyTextView.text = _article.bodyText;
        bodyTextView.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:bodyTextView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Subview origins
    NSInteger bodyTextHeightOrigin = 450;
    
    // Subview padding
    NSInteger bodyTextSidePadding = 0;
  
    // Body Text frame
    CGSize textViewSize = [bodyTextView sizeThatFits:CGSizeMake(bodyTextView.frame.size.width, FLT_MAX)];
    bodyTextView.frame = CGRectMake(bodyTextSidePadding, bodyTextHeightOrigin, self.frame.size.width - (bodyTextSidePadding * 2), textViewSize.height);
}

@end
