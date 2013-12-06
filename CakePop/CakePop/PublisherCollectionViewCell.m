//
//  PublisherCollectionViewCell.m
//  CakePop
//
//  Created by Christina Yoon on 12/2/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "PublisherCollectionViewCell.h"

@implementation PublisherCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] initWithFrame:self.bounds];
        self.autoresizesSubviews = YES;
        self.label.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        self.label.font = [UIFont boldSystemFontOfSize:42];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.adjustsFontSizeToFitWidth = YES;
        [self addSubview:self.label];
        
        [self setBackgroundColor:[UIColor whiteColor]];
        
        CGFloat borderWidth = 3.0f;
        CGRect myContentRect = CGRectInset(self.contentView.bounds, borderWidth, borderWidth);
        UIView* myContentView = [[UIView alloc]initWithFrame:myContentRect];
        myContentView.backgroundColor = [UIColor whiteColor];
        myContentView.layer.borderColor = [UIColor redColor].CGColor;
        myContentView.layer.borderWidth = borderWidth;
        [self.contentView addSubview:myContentView];
        
        [self setNumber:0];
    }
    return self;
}

- (void)setNumber:(NSInteger)number {
    self.label.text = [NSString stringWithFormat:@"%d", number];
    self.cellNumber = number;
}

/*
 -(void)prepareForReuse {
 [_newsView removeFromSuperview];
 _newsView = nil;
 }
 */
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
