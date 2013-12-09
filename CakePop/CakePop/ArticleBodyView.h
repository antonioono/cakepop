//
//  ArticleBodyView.h
//  CakePop
//
//  Created by Christina Yoon on 12/8/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

@class Article;

#import <UIKit/UIKit.h>

@interface ArticleBodyView : UIScrollView

@property (nonatomic, strong) Article* article;
@property (nonatomic, assign) NSInteger cellNumber;


- (id)initWithFrame:(CGRect)frame article:(Article *)article;

@end
