//
//  Publisher.m
//  CakePop
//
//  Created by Christina Yoon on 12/6/13.
//  Copyright (c) 2013 Yolo. All rights reserved.
//

#import "Publisher.h"

@implementation Publisher

- (id)initWithImageNameUnread:(NSString *)imageNameUnread imageNameRead:(id)imageNameRead
{
    _imageNameUnread = imageNameUnread;
    _imageNameRead = imageNameRead;
    _isRead = NO;
    
    return self;
}

- (void)setIsRead:(BOOL)isRead
{
    _isRead = isRead;
}

@end
