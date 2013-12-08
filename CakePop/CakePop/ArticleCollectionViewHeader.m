//
//  ArticleCollectionViewHeader.m
//  CakePop
//
//  Created by Christina Yoon on 12/7/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Publisher.h"

#import "ArticleCollectionViewHeader.h"

@interface ArticleCollectionViewHeader ()

@property(nonatomic, strong) UIImageView* backButtonImageView;
@property(nonatomic, strong) UIButton* backButton;
@property(nonatomic, strong) UIImageView* logoImageView;

@end

@implementation ArticleCollectionViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor blackColor]];
        
        _logoImageView = [[UIImageView alloc] init];
        [self addSubview:_logoImageView];
        
        _backButton = [[UIButton alloc] init];
        [_backButton setBackgroundColor:[UIColor whiteColor]];
        [_backButton addTarget:self
                   action:@selector(backPressed) forControlEvents:UIControlEventTouchDown];
        UIImage* backButtonImage = [UIImage imageNamed:@"backButton.png"];
        [_backButton setImage:backButtonImage forState:UIControlStateNormal];
        [self addSubview:_backButton];
    }
    return self;
}

- (void)backPressed
{
    NSLog(@"Back was pressed!");
    [_delegate backPressed];
}

- (void)setHeaderImageName:(NSString *)headerImageName
{
    UIImage* image = [UIImage imageNamed:headerImageName];
    [_logoImageView setImage:image];
    _logoImageView.contentMode = UIViewContentModeScaleAspectFit;
}

- (void)layoutSubviews {
    [super layoutSubviews];
 
    CGFloat mainScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGRect logoImageViewFrame = CGRectMake(mainScreenWidth / 3, self.frame.size.height / 3, mainScreenWidth / 3, self.frame.size.height / 3);
    _logoImageView.frame = logoImageViewFrame;
    
    CGRect backButtonFrame = CGRectMake(self.frame.origin.x, self.frame.size.height / 3, mainScreenWidth / 3, self.frame.size. height / 3);
    _backButton.frame = backButtonFrame;
}

@end
