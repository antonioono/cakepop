//
//  Article.m
//  CakePop
//
//  Data object for a single article
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"

@implementation Article

- (id)initWithTitleText:(NSString *)titleText bodyText:(NSString *)bodyText imageName:(NSString *)imageName authorName:(NSString *)authorName uri:(NSString *)uri
{
    _titleText = titleText;
    _bodyText = bodyText;
    _imageName = imageName;
    _authorName = authorName;
    _uri = uri;
    
    return self;
}

@end
