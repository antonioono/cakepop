//
//  ArticleListCell.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

@class Article;

#import <UIKit/UIKit.h>

#import "ArticleBodyView.h"

@protocol ArticleViewDelegate <NSObject>
@required
- (void) backPressed;
@end

@interface ArticleView : UIView <ArticleBodyViewDelegate>

@property (nonatomic, strong) Article* article;

@property(nonatomic, strong) id<ArticleViewDelegate> delegate;

- (id)initWithFrame:(CGRect)frame article:(Article *)article;

@end
