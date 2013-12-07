//
//  ArticleCollectionViewCell.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "ArticleCollectionViewCell.h"

@implementation ArticleCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        [self addSubview:self.imageView];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat borderWidth = 3.0f;
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        UIView* myContentView = [[UIView alloc]initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor blackColor].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        [self.contentView addSubview:myContentView];
        
        [self setNumber:0];
    }
    return self;
}

- (void)setNumber:(NSInteger)number
{
    self.cellNumber = number;
}

- (void)setImageUnread:(NSString*)imageNameUnread imageNameRead:(NSString*)imageNameRead isRead:(BOOL)isRead
{
    self.imageNameUnread = imageNameUnread;
    self.imageNameRead = imageNameRead;
    if (!isRead) {
        UIImage* image = [UIImage imageNamed:imageNameUnread];
        [self.imageView setImage:image];
    } else {
        UIImage* image = [UIImage imageNamed:imageNameRead];
        [self.imageView setImage:image];
    }
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
