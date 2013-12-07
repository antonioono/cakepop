//
//  Publisher.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Publisher.h"

@implementation Publisher

- (id)initWithImageName:(NSString *)imageName
{
    _imageName = imageName;
    _read = NO;
    
    return self;
}

- (void)setIsRead:(BOOL)isRead
{
    _read = isRead;
}

@end
