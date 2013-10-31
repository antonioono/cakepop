//
//  Article.h
//  CakePop
//
//  Created by Christina Yoon on 10/31/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Article : NSObject

@property (nonatomic, strong) NSString* titleText;
@property (nonatomic, strong) NSString* bodyText;
@property (nonatomic, strong) NSString* imageName;

- (id)initWithTitleText:(NSString *)titleText bodyText:(NSString *)bodyText imageName:(NSString *)imageName;

@end
