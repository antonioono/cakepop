//
//  ArticleCollectionViewCell.h
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Article.h"
#import "ArticleView.h"

@interface ArticleCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger cellNumber;

@property (nonatomic, strong) Article* article;
@property (nonatomic, strong) ArticleView* articleView;
@property (nonatomic, strong) UITextView* titleTextView;
@property (nonatomic, strong) UILabel* authorLabel;
@property (nonatomic, strong) UIImageView* backButton;

- (void)setArticle:(Article *)article;
- (void)setNumber:(NSInteger)number;

@end