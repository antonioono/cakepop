//
//  ArticleCollectionViewHeader.m
//  CakePop
//
//  Created by Christina Yoon on 12/7/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Publisher.h"

#import "ArticleCollectionViewHeader.h"

@implementation ArticleCollectionViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor whiteColor]];
        self.imageView = [[UIImageView alloc] initWithFrame:self.frame];
        //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)backPressed
{
    [_delegate backPressed];
}

- (void)setHeaderImageName:(NSString *)headerImageName
{
    UIImage* image = [UIImage imageNamed:headerImageName];
    [self.imageView setImage:image];
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
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
