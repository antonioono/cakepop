//
//  Article.m
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Article.h"

@implementation Article

- (id)initWithTitleText:(NSString *)titleText bodyText:(NSString *)bodyText imageName:(NSString *)imageName
{
    _titleText = titleText;
    _bodyText = bodyText;
    _imageName = imageName;
    
    return self;
}

@end
