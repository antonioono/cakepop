//
//  ArticleListCell.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

@class Article;

#import <UIKit/UIKit.h>

@interface ArticleView : UIScrollView

@property (nonatomic, strong) Article* article;

- (id)initWithFrame:(CGRect)frame article:(Article *)article;

@end
